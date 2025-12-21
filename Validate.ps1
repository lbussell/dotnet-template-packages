#!/usr/bin/env pwsh

$artifactsDir = "$PSScriptRoot/artifacts"
$nupkgDir = "$PSScriptRoot/bin/Release"

# Clear out artifacts directory
if (Test-Path $artifactsDir) {
    Remove-Item $artifactsDir -Recurse -Force
}
New-Item -ItemType Directory -Path $artifactsDir

# Clear out any existing nupkgs
if (Test-Path $nupkgDir) {
    Remove-Item "$nupkgDir/*.nupkg" -Force
}

# Pack the template package
dotnet pack "$PSScriptRoot" -c Release

# Find and install the template package
$nupkg = Get-ChildItem "$nupkgDir/*.nupkg" | Select-Object -First 1
dotnet new install $nupkg.FullName --force

# Generate a new project from the template
dotnet new nuget-package-repo --name TestPackage --output $artifactsDir

# Build the generated project
pushd $artifactsDir
dotnet build
dotnet test
dotnet pack
popd

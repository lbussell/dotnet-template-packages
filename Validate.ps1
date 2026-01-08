#!/usr/bin/env pwsh

$artifactsDir = "$PSScriptRoot/../template-tests"
$nupkgDir = "$PSScriptRoot/bin/Release"

# Uninstall old versions
dotnet new uninstall LoganBussell.Templates

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

# Generate new projects from the template

$noAuthors = "$artifactsDir/no-authors-no-license"
echo "Generating $noAuthors"
mkdir $noAuthors
dotnet new nuget-package-repo --output $noAuthors
pushd $noAuthors
dotnet test
dotnet pack
popd

$withAuthors = "$artifactsDir/with-authors-and-license"
echo "Generating $withAuthors"
mkdir $withAuthors
dotnet new nuget-package-repo --authors "YourName" --licenseExpression "MIT-0" --output $withAuthors
pushd $withAuthors
dotnet test
dotnet pack
popd

$CustomName = "$artifactsDir/custom-name"
echo "Generating $CustomName"
mkdir $CustomName
dotnet new nuget-package-repo --name "CustomName" --authors "YourName" --licenseExpression "MIT-0" --output $CustomName
pushd $CustomName
dotnet test
dotnet pack
popd

$toolProject = "$artifactsDir/tool-project"
echo "Generating $toolProject"
mkdir $toolProject
dotnet new nuget-package-repo --name "MyTool" --publishAsTool --toolCommandName "mytool" --authors "YourName" --licenseExpression "MIT-0" --output $toolProject
pushd $toolProject
dotnet build
dotnet pack
popd

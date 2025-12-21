#!/usr/bin/env pwsh

$artifactsDir = "$PSScriptRoot/artifacts"

# Clear out artifacts directory
if (Test-Path $artifactsDir) {
    Remove-Item $artifactsDir -Recurse -Force
}
New-Item -ItemType Directory -Path $artifactsDir

# Install the template
dotnet new install "$PSScriptRoot/src/nuget-package-repo/" --force

# Generate a new project from the template
dotnet new nuget-package-repo --name TestPackage --output $artifactsDir

# Build the generated project
pushd $artifactsDir
dotnet build
dotnet test
dotnet pack
popd

# Logan Bussell's .NET Templates

[![Build](https://github.com/lbussell/dotnet-template-packages/actions/workflows/build.yml/badge.svg?branch=main&event=push)](https://github.com/lbussell/dotnet-template-packages/actions/workflows/build.yml)

## Project Templates

### `nuget-package-repo`

This project template sets up a new repo that's ready for NuGet package
publishing.

It has the following features already set up out of the box:

- [NuGet.org Trusted Publishing](https://learn.microsoft.com/nuget/nuget-org/trusted-publishing)
- Central package management
- GitHub workflows for package publishing and PR validation
- New `*.slnx` solution file format
- Test project using MSTest
- Editorconfig and Gitignore
- VS Code extension recommendations (just the basics - C# and Editorconfig)
- Detailed instructions on NuGet package publishing best practices

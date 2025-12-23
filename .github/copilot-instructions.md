# Copilot Agent Instructions for dotnet-template-packages

## Repository Summary

This repository contains .NET template packages for quickly creating NuGet packages and tools. The main output is the `LoganBussell.Templates` NuGet package, which provides the `nuget-package-repo` template for scaffolding a complete NuGet package repository with tests, build configuration, and CI/CD workflows.

- **Project Type**: .NET Template Package (NuGet)
- **Target Framework**: .NET 10.0 (`net10.0`)
- **Languages**: C#, PowerShell
- **License**: MIT

---

## Build Commands

### Build the Template Package

```bash
dotnet build
```

### Pack for Release

```bash
dotnet pack -c Release --output packages
```

For stable release versions (no prerelease suffix):

```bash
dotnet pack -c Release -p:StableVersion=true --output packages
```

### Validate Templates

Run the validation script to test all template scenarios. This script:
1. Uninstalls any previous template versions
2. Builds and packs the template package
3. Installs the template locally
4. Generates projects with different parameter combinations
5. Runs `dotnet test` and `dotnet pack` on each generated project

```bash
pwsh -File Validate.ps1
```

**Note**: The validation script creates an `artifacts/` directory with generated test projects. This directory is git-ignored and should be cleaned between runs.

### Clean Build Artifacts

```bash
rm -rf bin obj packages artifacts
```

---

## Project Layout

```
├── LoganBussell.Templates.csproj   # Main project file for the template package
├── README.md                        # Repository documentation
├── Validate.ps1                     # Template validation script (PowerShell)
├── .editorconfig                    # Code style configuration
├── .gitignore                       # Git ignore rules
├── LICENSE                          # MIT license
├── .github/
│   └── workflows/
│       ├── build.yml                # CI build workflow (runs on push/PR)
│       └── publish-nuget.yml        # Manual NuGet publishing workflow
└── src/
    └── nuget-package-repo/          # Template source files
        ├── .template.config/
        │   └── template.json        # Template configuration and parameters
        ├── .editorconfig            # Template's editorconfig
        ├── .gitignore               # Template's gitignore
        ├── MyPackage.1.slnx         # Template solution file
        └── src/
            ├── Directory.Build.props      # Shared build properties
            ├── Directory.Packages.props   # Central package management
            ├── MyPackage.1/               # Main package project
            │   ├── MyPackage.1.csproj
            │   └── Class1.cs
            └── MyPackage.1.Tests/         # Test project (MSTest)
                ├── MyPackage.1.Tests.csproj
                ├── MSTestSettings.cs
                └── Test1.cs
```

---

## CI/CD Workflows

### Build Workflow (`.github/workflows/build.yml`)
- **Triggers**: Push to `main`, tags, pull requests, and workflow_call
- **Actions**: Restores, builds, and packs the template package
- **Artifacts**: Uploads `.nupkg` files as `nuget-packages` artifact

### Publish Workflow (`.github/workflows/publish-nuget.yml`)
- **Trigger**: Manual (`workflow_dispatch`)
- **Actions**: Builds package and publishes to NuGet.org using OIDC trusted publishing
- **Requires**: `NUGET_USER` secret and `production` environment

---

## Template Parameters

When using the `nuget-package-repo` template, these parameters are available:

| Parameter | Description | Default |
|-----------|-------------|---------|
| `--name` | Package name (replaces `MyPackage.1` in all files) | Directory name |
| `--output` | Output directory | Current directory |
| `--authors` | Comma-separated list of package authors for SPDX headers | Empty |
| `--licenseExpression` | SPDX license expression (e.g., `MIT`, `Apache-2.0`) | Empty |

**Note**: When `--authors` or `--licenseExpression` are provided, file headers with SPDX copyright/license tags are automatically generated in source files.

---

## Coding Conventions

- **EditorConfig**: Follow `.editorconfig` rules at the repository root
- **Indentation**: 4 spaces for C#, 2 spaces for XML/JSON files
- **Naming**: PascalCase for public members, `_camelCase` for private fields, `s_camelCase` for static fields
- **Namespaces**: File-scoped namespace declarations preferred
- **Nullability**: Nullable reference types enabled (`<Nullable>enable</Nullable>`)
- **Implicit Usings**: Enabled (`<ImplicitUsings>enable</ImplicitUsings>`)

---

## Important Notes for Agents

1. **Always use `dotnet pack`** instead of `dotnet build` for the main project since it's a template package.

2. **Validation is critical**: After making changes to template files in `src/nuget-package-repo/`, always run `pwsh -File Validate.ps1` to verify templates generate and build correctly.

3. **Template files use conditional directives**: Files like `Class1.cs` use `//#if` and `//#endif` preprocessor directives for template conditionals. These are NOT C# preprocessor directives.

4. **Version is auto-generated**: Package versions are configured in `LoganBussell.Templates.csproj` with format `MAJOR.MINOR.PATCH-preview.YYYY.MM.DD` for prereleases.

5. **No solution file at root**: Use `dotnet pack` or `dotnet build` on the `.csproj` file directly.

6. **Central Package Management**: The template uses NuGet Central Package Management in `src/nuget-package-repo/src/Directory.Packages.props`.

7. **Trust these instructions**: Only search the codebase if information here is incomplete or found to be incorrect.

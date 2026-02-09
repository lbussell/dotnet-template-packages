# MyPackage.1

## Getting Started

### Prerequisites

- Install the [.NET SDK](https://dotnet.microsoft.com/download)

### Build and Test

Build the project:

```bash
dotnet build
```

Run tests:

```bash
dotnet test
```

## Publishing Your Package

This repository includes GitHub Actions workflows for automated building and
publishing to NuGet.org.

### Set Up NuGet Trusted Publishing

1. **Create a [NuGet.org](https://www.nuget.org) account** if you don't already have one.
2. **Run setup script**:
   - `dotnet scripts/SetupPublishing.cs` (requires .NET 10+ SDK)
   - This script will walk you through setting up a production environment and
     initializing your environment with your NuGet.org username.
3. **Set up Trusted Publishing to NuGet.org**:
   - Follow the instructions output by the setup script.

### Updating Package Version Numbers

Version numbers are controlled in
[`MyPackage.1.csproj`](`./src/MyPackage.1/MyPackage.1.csproj`). This template
starts with the version number `0.1.0`. I recommend that you follow [Semantic
Versioning](https://semver.org/). In practice, that means doing the following:

- Increment `<PatchVersion>` property whenever you make backwards-compatible
  bug fixes.
- Increment `<MinorVersion>` property whenever you add new features.
- Increment `<MajorVersion>` property whenever you make breaking changes.

### Publishing a Pre-Release Package

Pre-release packages are useful for testing and early access. They include a
version suffix like `-preview.yyyy.M.d`.

1. Go to the **Actions** tab in your GitHub repository
2. Select the **Publish NuGet Package** workflow
3. Click **Run workflow**
4. Leave **"Publish as a stable version"** **unchecked** (default)

The package will be published with a version like `0.1.0-preview.2025.12.21`.

### Publishing a Stable Release

Stable releases have no pre-release suffix (e.g., `0.1.0`, `1.2.4`,
`99.99.99`).

1. **Update the version numbers** (see section below)
2. Commit and push your changes
3. Go to the **Actions** tab in your GitHub repository
4. Select the **Publish NuGet Package** workflow
5. Click **Run workflow**
6. **Check** the **"Publish as a stable version"** checkbox
7. Click **Run workflow**

The package will be published with a stable version. You will then want to bump
the major/minor/patch version so that you can start working on the next
release.

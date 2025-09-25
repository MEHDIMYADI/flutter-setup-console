# Flutter Setup Console

This batch script automates the setup process for Flutter development on Windows. It includes several commonly needed configuration steps for Flutter and Android development. 

## Features

1. **Disable Flutter Telemetry**: Disables Flutter's data collection.
2. **Accept Android Licenses**: Automatically accepts all Android licenses needed for Flutter.
3. **Set Android SDK Path**: Easily set the Android SDK directory using a file picker dialog.
4. **Set Android Studio Path**: Easily set the Android Studio directory using a file picker dialog.
5. **Force Flutter Package Upgrade**: Upgrades all Flutter dependencies to their latest versions.
6. **Run Flutter Doctor**: Checks your Flutter installation and environment for any missing dependencies.
7. **Upgrade Flutter**: Upgrades Flutter to the latest stable version.
8. **Disable Visual Studio Check for Mobile Projects**: Disables the Visual Studio check for mobile-only projects.

## Requirements

- **Windows operating system**
- **Git installed and configured**
- **Flutter SDK installed**
- **Android SDK installed** (You will be prompted to select the SDK path during the script execution)

## Usage

1. **Run the script as Administrator**: 
   Right-click the batch file and choose "Run as Administrator" to ensure all necessary permissions are granted.
   
2. **Select options from the menu**:
   Once the script runs, you'll be presented with a menu of options. Enter the corresponding number to perform the desired action.

3. **Follow the instructions**:
   For certain actions like selecting the Android SDK or Android Studio directories, the script will open a file picker dialog for you to choose the path.

## How to fix Git Ownership Issues

If you encounter the error `fatal: detected dubious ownership in repository`, the script automatically fixes this issue by marking the Flutter SDK directory as a safe directory for Git to use. This prevents errors related to ownership mismatches between Git and your system.

## License

This project is licensed under the BSD-style license.

## Author

[Mehdi Dimyadi](https://github.com/mehdimyadi)

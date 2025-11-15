# mythral

Welcome to Mythral, below you will find instructions on how to work with this repo

## Creating a new package

run the command below with your package name

```bash
flutter create --template=package packages/core
```

## Running the App in Development Mode

Below are the commands to run the app in development mode on different platforms:

### macOS

```bash
flutter run -d macos
```

### iOS (Simulator)

```bash
flutter run -d ios
```

### iOS (Physical Device)

```bash
flutter run -d ios --device-id <device-id>
```

### Android (Emulator)

```bash
flutter run -d android
```

### Linux

```bash
flutter run -d linux
```

### Windows

```bash
flutter run -d windows
```

### List Available Devices

To see all available devices and their IDs:

```bash
flutter devices
```

### Hot Reload

Once the app is running, you can use:

- `r` to hot reload
- `R` to hot restart
- `q` to quit

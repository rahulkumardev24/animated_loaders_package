<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# animated_loaders

A beautiful collection of smooth, customizable **dot-based loading animations** for Flutter.  
This package provides modern, minimal and user-friendly loaders ideal for all types of apps.

## Features

- ✔ Four high-quality dot animations:
    - **Bouncing Dots**
    - **Wave Dots**
    - **Scaling Dots**
    - **Fading Dots**
- ✔ Lightweight and easy to use
- ✔ Fully customizable (size, color, speed, dot count)
- ✔ Smooth animations with no jank
- ✔ Supports Android, iOS, Web, Desktop
- ✔ Includes visibility controls (fade-in & fade-out)

> *(You may add GIFs or screenshots in this section.)*

---

## Getting started

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  bouncy_dots_loader : ^0.0.1
```

Import it in your Dart file:
```dart
import 'package:bouncy_dots_loader/bouncy_dots_loader.dart';
```

Usage
---
🔵 Example: Bouncing Dots Loader

```dart
BouncingDotsLoader(
type: AnimatedLoaderType.bouncingDots,
size: 60,
color: Colors.blue,
);
```

🌊 Wave Dots
---
```dart
BouncingDotsLoader(
  type: AnimatedLoaderType.waveDots,
  size: 50,
  color: Colors.green,
);
```
🔍 Scaling Dots
---

```dart
BouncingDotsLoader(
type: AnimatedLoaderType.scalingDots,
size: 48,
color: Colors.orange,
);
```
🌫 Fading Dots
---

```dart
BouncingDotsLoader(
type: AnimatedLoaderType.fadingDots,
size: 42,
color: Colors.purple,
);
```
👁 With visibility animation (optional)
--- 
```dart
BouncingDotsLoader(
type: AnimatedLoaderType.bouncingDots,
visible: false,   // Smooth fade-out effect
);
```

---

Additional information

This package is open-source and contributions are welcome!
You can:

⭐ Star the GitHub repository

🐞 Report issues

🔧 Submit pull requests

📢 Suggest new loader styles

If you face any problems, feel free to open an issue.
Thank you for using animated_loaders 🎉










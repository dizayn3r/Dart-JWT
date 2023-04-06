<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Dart JWT package lets you create jwt token.

## Installation

1. Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  dart_jwt: ^0.0.1
```

2. You can install packages from the command line with Flutter:

```bash
$ dart pub get
```

3. Import the package and use it in your Flutter App.

```dart
import 'package:dart_jwt/dart_jwt.dart';
```

## Usage

### Create JWT Token

```dart
String createToken(
    {required Map payload,
      required Map<String, dynamic> headers,
      required SecretKey key}) {
  String token = "";
  final jwt = JWT(payload, header: headers);
  token = jwt.sign(key);
  return token;
}
```

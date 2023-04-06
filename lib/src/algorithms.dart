import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'errors.dart';
import 'keys.dart';

abstract class JWTAlgorithm {
  /// HMAC using SHA-256 hash algorithm
  static const HS256 = _HMACAlgorithm('HS256');

  /// HMAC using SHA-384 hash algorithm
  static const HS384 = _HMACAlgorithm('HS384');

  /// HMAC using SHA-512 hash algorithm
  static const HS512 = _HMACAlgorithm('HS512');

  /// Return the `JWTAlgorithm` from his string name
  static JWTAlgorithm fromName(String name) {
    switch (name) {
      case 'HS256':
        return JWTAlgorithm.HS256;
      case 'HS384':
        return JWTAlgorithm.HS384;
      case 'HS512':
        return JWTAlgorithm.HS512;
      default:
        throw JWTInvalidError('unknown algorithm');
    }
  }

  const JWTAlgorithm();

  /// `JWTAlgorithm` name
  String get name;

  /// Create a signature of the `body` with `key`
  ///
  /// return the signature as bytes
  Uint8List sign(JWTKey key, Uint8List body);

  /// Verify the `signature` of `body` with `key`
  ///
  /// return `true` if the signature is correct `false` otherwise
  bool verify(JWTKey key, Uint8List body, Uint8List signature);
}

class _HMACAlgorithm extends JWTAlgorithm {
  final String _name;

  const _HMACAlgorithm(this._name);

  @override
  String get name => _name;

  @override
  Uint8List sign(JWTKey key, Uint8List body) {
    assert(key is SecretKey, 'key must be a SecretKey');
    final secretKey = key as SecretKey;

    final hmac = Hmac(_getHash(name), utf8.encode(secretKey.key));

    return Uint8List.fromList(hmac.convert(body).bytes);
  }

  @override
  bool verify(JWTKey key, Uint8List body, Uint8List signature) {
    assert(key is SecretKey, 'key must be a SecretKey');

    final actual = sign(key, body);

    if (actual.length != signature.length) return false;

    for (var i = 0; i < actual.length; i++) {
      if (actual[i] != signature[i]) return false;
    }

    return true;
  }

  Hash _getHash(String name) {
    switch (name) {
      case 'HS256':
        return sha256;
      case 'HS384':
        return sha384;
      case 'HS512':
        return sha512;
      default:
        throw ArgumentError.value(name, 'name', 'unknown hash name');
    }
  }
}

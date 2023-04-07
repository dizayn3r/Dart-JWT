abstract class JWTKey {}

/// For HMAC algorithms
class SecretKey extends JWTKey {
  String key;

  SecretKey(this.key);
}

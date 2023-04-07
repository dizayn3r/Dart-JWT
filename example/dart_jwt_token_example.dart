import 'package:dart_jwt_token/dart_jwt_token.dart';

void main() {
  hs256();
}

String createToken(
    {required Map payload,
    required Map<String, dynamic> headers,
    required SecretKey key}) {
  String token = "";
  final jwt = JWT(payload, header: headers);
  token = jwt.sign(key);
  return token;
}

void hs256() {
  String token;
  Map payload = {"name": "John Doe", "age": 30};
  Map<String, dynamic> headers = {'alg': 'HS256', 'typ': 'JWT'};
  SecretKey key = SecretKey('Secret Paraphrase');

  token = createToken(payload: payload, headers: headers, key: key);
  print('Signed token:\n$token\n');

  Map<String, dynamic> decodedPayload = verifyToken(token, key);
  print("Payload:\n$decodedPayload\n");
}

Map<String, dynamic> verifyToken(String token, SecretKey key) {
  try {
    // Verify a token
    final jwt = JWT.verify(token, key);
    return jwt.payload;
  } on JWTExpiredError {
    return {"expired": true};
  } on JWTError catch (ex) {
    return {"Error": ex.message};
  }
}

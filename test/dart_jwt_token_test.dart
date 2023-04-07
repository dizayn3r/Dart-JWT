import 'package:dart_jwt_token/dart_jwt_token.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    Map payload = {"name": "John Doe", "age": 30};
    Map<String, dynamic> headers = {'alg': 'HS256', 'typ': 'JWT'};
    SecretKey key = SecretKey('Secret Paraphrase');

    final jwt = JWT(payload, header: headers);
    String token = "";
    Map<String, dynamic> decodedPayload = {};
    final jwtVerify = JWT.verify(token, key);
    setUp(() {
      token = jwt.sign(key);
      decodedPayload = jwtVerify.payload;
    });

    test('Check Token Creation', () {
      expect(token.isNotEmpty, isTrue, reason: "Checking token");
    });

    test('Check Token Verification', () {
      expect(decodedPayload.isNotEmpty, isTrue);
    });
  });
}

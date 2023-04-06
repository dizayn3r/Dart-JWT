import 'package:dart_jwt/dart_jwt.dart';

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
  Map payload = {
    "merchantID": "JT04",
    "invoiceNo": "18847914250",
    "description": "Credit card payment",
    "amount": "1.00",
    "currencyCode": "THB",
    "nonceStr": "a8092512-b144-41b0-8284-568bb5e9264c",
    "paymentChannel": ["CC"],
    "tokenize": true
  };
  Map<String, dynamic> headers = {'alg': 'HS256', 'typ': 'JWT'};

  SecretKey key = SecretKey(
      'CD229682D3297390B9F66FF4020B758F4A5E625AF4992E5D75D311D6458B38E2');

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


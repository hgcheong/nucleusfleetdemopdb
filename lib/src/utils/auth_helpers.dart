import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class EncryptHelpers {
  static Encrypter authEnc() {
    var parser = RSAKeyParser();
    RSAPublicKey publicKey = parser.parse(
            "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt4k2LaAwRP7Yp+OwyQMdyHsK8IzOEm72sC+4wQuEp3KZNDuunw0EO5kUQafNBFDmzPAxgpS5UiuTrYdI1jtreha0vxEfEOKOrm36LVzg0NVPiovL9aIzHJOo3zZpjIDlUmYIt3TehwFErut4HbjbxhlcF+fyWqyQM+dRWochUje+C3XmqhEpsxzE9pw5lrVbb8aYLHWPqoQl9kS9kEPHBYVb531gGd9ic7OqUqVTJSL4wY9tEO6oBAleiXmDVAZ0mg+/oiKhhQBe4q+pqLoKrbXJIjq3hImBSDtjazNTK/EA7aNvm5Ssu0DFWu00zDwxOmTE8BfcVLcwv8p5vclQ1wIDAQAB\n-----END PUBLIC KEY-----")
        as RSAPublicKey;
    Encrypter encrypter;
    encrypter = Encrypter(
      RSA(publicKey: publicKey, encoding: RSAEncoding.OAEP),
    );
    return encrypter;
  }
}

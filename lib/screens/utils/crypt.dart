import 'package:encrypt/encrypt.dart';

mixin Crypt {
  static final key = Key.fromUtf8('my 32 length key................');
  static final iv = IV.fromLength(16);

  static String encryptPassword(String password) {
    final encrypter = Encrypter(AES(key));
    final encryptedPassword = encrypter.encrypt(
      password,
      iv: iv,
    );
    return encryptedPassword.base64;
  }

  static String decryptePassword(String encryptedPassword) {
    final encrypter = Encrypter(AES(key));
    final decryptedPassword = encrypter.decrypt64(
      encryptedPassword,
      iv: iv,
    );
    return decryptedPassword;
  }
}

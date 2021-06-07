import 'dart:convert';
import 'dart:io';

class ImageUtils {
  /*Metodo para decodificar foto en base64 */
  static decodePhoto({required String photo}) {
    final decodeBytes = base64Decode(photo);
    return decodeBytes;
  }

  /*Metodo para encodificar image a base 64 */
  static Future<String> encodePhoto({required File file}) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  /*Para comprobar si el path de la imagen es de URL */
  static bool isNetwork({required String image}) {
    RegExp reg = RegExp(r"^https");

    return reg.hasMatch(image);
  }
}

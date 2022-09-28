import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
// import 'dart:io';
// import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';
import 'package:path_provider/path_provider.dart';
// import 'dart:io' as Io;

class QrRepository {
  String mainUrl = "https://banban-hr.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  Uint8List? _bytes;

  // Future<Uint8List?> getQR() async {
  //   try {
  //     String url = "https://banban-hr.herokuapp.com/api/qr";

  //     Response response = await apiProvider.get(url, null, null);
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       _bytes = Base64Decoder().convert(response.data['data']);
  //       return _bytes;
  //     }
  //     throw CustomException.generalException();
  //   } catch (e) {
  //     throw e;
  //   }
  // }
  Future<String> getQR() async {
    try {
      String url = "https://banban-hr.herokuapp.com/api/qr";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        _bytes = Base64Decoder().convert(response.data['data']);
        return response.data['data'];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  _decodeImage({required String image}) {
    //  final decodedBytes = base64Decode(image);
    // var file = Io.File("qr.png");
    // file.writeAsBytesSync(decodedBytes);
    var bytes = utf8.encode(image);
    base64.encode(bytes);
  }
  
}

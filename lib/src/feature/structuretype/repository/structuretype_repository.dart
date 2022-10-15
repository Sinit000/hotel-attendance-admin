import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotle_attendnce_admin/src/feature/structuretype/model/structuretype_model.dart';

import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class StructuretypeRepository {
  String mainUrl = "${dotenv.env['baseUrl']}";
  ApiProvider _apiProvider = ApiProvider();
  Future<List<StructuretypeModel>> getStructuretype(
      {required int rowperpage, required int page}) async {
    try {
      String url =
          "${dotenv.env['baseUrl']}structuretypes?page_size=$rowperpage&page=$page";
      Response response = await _apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<StructuretypeModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(StructuretypeModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addStructuretype({
    required String name,
  }) async {
    try {
      String url = mainUrl + "structuretypes/add";
      Map body = {
        "name": name,
      };
      Response response = await _apiProvider.post(url, body, null);

      print(response.statusCode);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        print(response.data);
        return;
      } else if (response.data["code"].toString() != "0") {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> editStructuretype({
    required String id,
    required String name,
  }) async {
    try {
      String url = mainUrl + "structuretypes/edit/$id";
      Map body = {
        "name": name,
      };
      Response response = await _apiProvider.put(url, body);

      print(response.statusCode);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        print(response.data);
        return;
      } else if (response.data["code"].toString() != "0") {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteStructuretype({
    required String id,
  }) async {
    try {
      String url = mainUrl + "structuretypes/delete/$id";

      Response response = await _apiProvider.delete(url, null);
      print(response.statusCode);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        print(response.data);
        return;
      } else if (response.data["code"].toString() != "0") {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotle_attendnce_admin/src/feature/structure/model/structure_model.dart';

import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class StructureRepository {
  String mainUrl = "${dotenv.env['baseUrl']}";
  ApiProvider _apiProvider = ApiProvider();
  Future<List<StructureModel>> getStructure(
      {required int rowperpage, required int page}) async {
    try {
      String url =
          "${dotenv.env['baseUrl']}structures?page_size=$rowperpage&page=$page";
      Response response = await _apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<StructureModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(StructureModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<StructureModel>> getAllStructure() async {
    try {
      String url = "${dotenv.env['baseUrl']}structures/all";
      Response response = await _apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);  
      if (response.statusCode == 200) {
        print(response.data);
        List<StructureModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(StructureModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addStructure({
    required String name,
    required String baseSalary,
    required String allowance,
    // required String currency,
    // required String structuretypeId
  }) async {
    try {
      String url = mainUrl + "structures/add";
      Map body = {
        "name": name,
        "base_salary": baseSalary,
        "allowance": allowance,
        // "currency": currency,
        // "structure_type_id": structuretypeId,
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

  Future<void> editStructure({
    required String id,
    required String name,
    required String baseSalary,
    required String allowance,
    // required String currency,
    // required String structuretypeId
  }) async {
    try {
      String url = mainUrl + "structures/edit/$id";
      Map body = {
        "name": name,
        "base_salary": baseSalary,
        "allowance": allowance,
        // "currency": currency,
        // "structure_type_id": structuretypeId,
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

  Future<void> deleteStructure({
    required String id,
  }) async {
    try {
      String url = mainUrl + "structures/delete/$id";

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

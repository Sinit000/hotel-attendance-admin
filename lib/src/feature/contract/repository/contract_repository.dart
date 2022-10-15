import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotle_attendnce_admin/src/feature/contract/model/contract_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class ContractRepository {
  String mainUrl = "${dotenv.env['baseUrl']}";
  ApiProvider _apiProvider = ApiProvider();
  Future<List<ContractModel>> getContract(
      {required int rowperpage, required int page}) async {
    try {
      String url =
          "${dotenv.env['baseUrl']}contracts?page_size=$rowperpage&page=$page";
      Response response = await _apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<ContractModel> leave = [];  
        response.data["data"].forEach((data) {
          leave.add(ContractModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<ContractModel>> getAllContract() async {
    try {
      String url = "${dotenv.env['baseUrl']}contracts/all";
      Response response = await _apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<ContractModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(ContractModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addContract(
      {required String userId,
      required String structureId,
      required String startedDate,
      required String endDate,
      required String workingSchedule,
      required String refCode}) async {
    try {
      String url = mainUrl + "contracts/add";
      Map body = {
        "user_id": userId,
        "structure_id": structureId,
        "start_date": startedDate,
        "end_date": endDate,
        "working_schedule": workingSchedule,
        "ref_code": refCode,
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

  Future<void> editContract(
      {required String id,
      required String userId,
      required String structureId,
      required String startedDate,
      required String endDate,
      required String workingSchedule,
      required String refCode}) async {
    try {
      String url = mainUrl + "contracts/edit/$id";
      Map body = {
        "user_id": userId,
        "structure_id": structureId,
        "start_date": startedDate,
        "end_date": endDate,
        "working_schedule": workingSchedule,
        "ref_code": refCode,
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

  Future<void> deleteContract({
    required String id,
  }) async {
    try {
      String url = mainUrl + "contracts/delete/$id";

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

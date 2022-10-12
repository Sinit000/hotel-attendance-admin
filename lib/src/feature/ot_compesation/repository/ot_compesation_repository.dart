import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/feature/ot_compesation/model/ot_compesation_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class OTCompesationRepository {
  String mainUrl = "https://banban-hr.herokuapp.com/api/";
  ApiProvider _apiProvider = ApiProvider();
  // for specific user
  Future<List<OTCompesationModel>> getOTCompesation(
      {required int page,
      required int rowperpage,
      required String startDate,
      required String endDate}) async {
    try {
      String url =
          "https://banban-hr.herokuapp.com/api/overtimes/compesations?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      // String url = mainUrl + "me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await _apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<OTCompesationModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(OTCompesationModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> editOTCompesation(
      {required int id, required String status}) async {
    try {
      String url = mainUrl + "overtimes/compesations/edit/$id";
      Map body = {
        "status": status,
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

  Future<void> deleteOTCompesation({
    required String id,
  }) async {
    try {
      String url = mainUrl + "me/compesations/delete/$id";

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

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotle_attendnce_admin/src/feature/leaveout/model/leaveout_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class LeaveOutRepository {
  String mainUrl = "${dotenv.env['baseUrl']}";
  ApiProvider apiProvider = ApiProvider();

  Future<List<LeaveOutModel>> getleaveout(
      {required int page,
      required int rowperpage,
      required String startDate,
      required String endDate}) async {
    try {
      String url =
          "${dotenv.env['baseUrl']}leaveouts?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      // String url = mainUrl + "me/leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<LeaveOutModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(LeaveOutModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  // for staff is chief department
  Future<void> editleaveOutStatusC({
    required String id,
    required String status,
  }) async {
    try {
      String url = mainUrl + "leaveouts/chief/edit/$id";
      Map body = {
        // "type": "company",
        "status": status,
      };
      Response response = await apiProvider.put(url, body);

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

  Future<void> deleteleaveOut({
    required String id,
  }) async {
    try {
      String url = mainUrl + "me/leaveouts/delete/$id";

      Response response = await apiProvider.delete(url, null);
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

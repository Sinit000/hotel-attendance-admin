import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/model/holiday_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class HolidayRepository {
  String mainUrl = "https://banban-hr.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  Future<List<HolidayModel>> getHoliday(
      {required int page, required int rowperpage}) async {
    try {
      String url = mainUrl + "holidays?page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<HolidayModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(HolidayModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addHoliday({
    required String name,
    required String fromDate,
    required String toDate,
    required String notes,
  }) async {
    try {
      String url = mainUrl + "holidays/add";
      Map body = {
        "name": name,
        "from_date": fromDate,
        "to_date": toDate,
        "notes": notes
      };
      Response response = await apiProvider.post(url, body, null);

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

  Future<void> editHoliday({
    required String id,
    required String name,
    required String fromDate,
    required String toDate,
    required String notes,
  }) async {
    try {
      String url = mainUrl + "holidays/edit/$id";
      Map body = {
        "name": name,
        "from_date": fromDate,
        "to_date": toDate,
        "notes": notes
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

  Future<void> deleteHoliday({
    required String id,
  }) async {
    try {
      String url = mainUrl + "holidays/delete/$id";

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

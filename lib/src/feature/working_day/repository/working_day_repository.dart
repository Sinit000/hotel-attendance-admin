import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/model/working_day_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class WorkingDayRepository {
  String mainUrl = "https://banban-hr.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  Future<List<WorkingDayModel>> getWorkdayList(
      {required int rowPerpage, required int page}) async {
    try {
      String url = mainUrl + "workdays?page_size=$rowPerpage&page=$page";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<WorkingDayModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(WorkingDayModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<WorkingDayModel>> getAllWorkday() async {
    try {
      String url = mainUrl + "workdays/all";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<WorkingDayModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(WorkingDayModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addWorkDay({
    required String name,
    required String notes,
    required String workDay,
    required String offDay,
  }) async {
    try {
      String url = mainUrl + "workdays/add";
      Map body = {
        "name": name,
        "working_day": workDay,
        "off_day": offDay,
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

  Future<void> editWorkday({
    required String id,
    required String name,
    required String notes,
    required String workDay,
    required String offDay,
  }) async {
    try {
      String url = mainUrl + "workdays/edit/$id";
      Map body = {
        "name": name,
        "working_day": workDay,
        "off_day": offDay,
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

  Future<void> deleteWorkday({
    required String id,
  }) async {
    try {
      String url = mainUrl + "workdays/delete/$id";

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

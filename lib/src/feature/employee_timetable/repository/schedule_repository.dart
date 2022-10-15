import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/model/employee_timetable_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class ScheduleRepository {
  String mainUrl = "${dotenv.env['baseUrl']}";
  ApiProvider apiProvider = ApiProvider();
  Future<List<EmployeeTimetablModel>> getSchedule(
      {required int rowPerpage, required int page}) async {
    try {
      String url = mainUrl + "schedules?page_size=$rowPerpage&page=$page";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<EmployeeTimetablModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(EmployeeTimetablModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addSchedule({
    required String employeeId,
    required String timetableId,
  }) async {
    try {
      String url = mainUrl + "schedules/add";
      Map body = {
        "user_id": employeeId,
        "timetable_id": timetableId,
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

  Future<void> editSchedule({
    required String id,
    required String employeeId,
    required String timetableId,
  }) async {
    try {
      String url = mainUrl + "schedules/edit/$id";
      Map body = {
        "user_id": employeeId,
        "timetable_id": timetableId,
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

  Future<void> deleteSchedule({
    required String id,
  }) async {
    try {
      String url = mainUrl + "schedules/delete/$id";

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

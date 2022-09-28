import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class TimetableRepository {
  String mainUrl = "https://banban-hr.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  Future<List<TimetableModel>> getTimetable(
      {required int rowPerpage, required int page}) async {
    try {
      String url = mainUrl + "timetables?page_size=$rowPerpage&page=$page";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<TimetableModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(TimetableModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<TimetableModel>> getAllTimetable() async {
    try {
      String url = mainUrl + "timetables/all";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<TimetableModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(TimetableModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addTimetable({
    required String name,
    required String onDuty,
    required String offDuty,
    required String lateMn,
    required String earlyMn,
  }) async {
    try {
      String url = mainUrl + "timetables/add";

      Map body = {
        "timetable_name": name,
        "on_duty_time": onDuty,
        "off_duty_time": offDuty,
        "late_minute": lateMn,
        "early_leave": earlyMn
      };
      print(lateMn);
      print(earlyMn);

      Response response = await apiProvider.post(url, body, null);

      print(response.statusCode);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        print(response.data);
        return;
      } else if (response.data["code"].toString() != "0") {
        throw response.data["message"];
      }
      // throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> editTimetable({
    required String id,
    required String name,
    required String onDuty,
    required String offDuty,
    required String lateMn,
    required String earlyMn,
  }) async {
    try {
      String url = mainUrl + "timetables/edit/$id";
      Map body = {
        "timetable_name": name,
        "on_duty_time": onDuty,
        "off_duty_time": offDuty,
        "late_minute": lateMn,
        "early_leave": earlyMn
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

  Future<void> deleteTimetable({
    required String id,
  }) async {
    try {
      print(id);
      String url = mainUrl + "timetablse/delete/$id";

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

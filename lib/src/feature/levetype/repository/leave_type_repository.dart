import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/model/leave_type_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class LeaveTypeRepository {
  String mainUrl = "https://banban-hr.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  Future<List<LeaveTypeModel>> getleaveType(
      {required int rowPerpage, required int page}) async {
    try {
      String url = mainUrl + "leavetypes?page_size=$rowPerpage&page=$page";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);

        List<LeaveTypeModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(LeaveTypeModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<LeaveTypeModel>> getAllleaveType() async {
    try {
      String url = mainUrl + "leavetypes/all";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<LeaveTypeModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(LeaveTypeModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addLeaveType({
    required String name,
    required String note,
  }) async {
    try {
      String url = mainUrl + "leavetypes/add";
      Map body = {
        "leave_type": name,
        "notes": note,
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

  Future<void> editLeaveType({
    required String id,
    required String name,
    required String note,
  }) async {
    try {
      String url = mainUrl + "leavetypes/edit/$id";
      Map body = {
        "leave_type": name,
        "notes": note,
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

  Future<void> deleteLeaveType({
    required String id,
  }) async {
    try {
      String url = mainUrl + "leavetypes/delete/$id";

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

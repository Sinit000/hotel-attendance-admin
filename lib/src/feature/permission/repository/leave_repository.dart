import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/model/leave_model.dart';

import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class LeaveRepository {
  String mainUrl = "https://banban-hr.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  // Future<List<LeaveTypeModel>> getleavetype() async {
  //   try {
  //     String url = mainUrl + "leavetype";

  //     Response response = await apiProvider.get(url, null, null);
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print(response.data);
  //       List<LeaveTypeModel> leave = [];
  //       response.data["data"].forEach((data) {
  //         leave.add(LeaveTypeModel.fromJson(data));
  //       });
  //       return leave;
  //     }
  //     throw CustomException.generalException();
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future<List<LeaveModel>> getleave(
      {required int page,
      required int rowperpage,
      required String startDate,
      required String endDate}) async {
    try {
      String url = mainUrl +
          "leaves?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<LeaveModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(LeaveModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addleave(
      {required String employeeId,
      required String leavetypeId,
      required String reason,
      required String number,
      required String fromDate,
      // required String date,
      required String toDate}) async {
    try {
      String url = mainUrl + "leaves/add";
      Map body = {
        // "type": "company",
        "user_id": employeeId,
        "reason": reason,
        "number": number,
        "from_date": fromDate,
        // "date": date,
        "to_date": toDate,
        "leave_type_id": leavetypeId
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

  Future<void> editleave(
      {required String id,
      required String leavetypeId,
      required String reason,
      required String number,
      required String fromDate,
      required String employeeId,
      required String toDate}) async {
    try {
      String url = mainUrl + "leaves/edit/$id";
      Map body = {
        // "type": "company",
        "user_id": employeeId,
        "reason": reason,
        "number": number,
        "from_date": fromDate,
        // "date": date,
        "to_date": toDate,
        "leave_type_id": leavetypeId
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

  Future<void> editleaveStatus({
    required String id,
    required String status,
    required String deduction,
  }) async {
    try {
      String url = mainUrl + "leaves/edit/$id";
      Map body = {
        "leave_deduction": deduction,
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

  Future<void> deleteleave({
    required String id,
  }) async {
    try {
      String url = mainUrl + "leaves/delete/$id";

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

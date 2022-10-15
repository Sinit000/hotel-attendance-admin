import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/model/user_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_detail_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/role/model/role_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class EmployeeRepository {
  String mainUrl = "${dotenv.env['baseUrl']}";
  ApiProvider apiProvider = ApiProvider();
  Future<List<EmployeeModel>> getEmployee(
      {required int rowPerpage, required int page}) async {
    try {
      String url = mainUrl + "employees?page_size=$rowPerpage&page=$page";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<EmployeeModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(EmployeeModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<EmployeeModel>> getEmployeeList(
      {required int rowPerpage, required int page}) async {
    try {
      String url = mainUrl + "employees/list?page_size=$rowPerpage&page=$page";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<EmployeeModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(EmployeeModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<EmployeeDetailModel> getEmployeeDetail({required String id}) async {
    try {
      String url = mainUrl + "employees&employee_id=$id";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return EmployeeDetailModel.fromJson(response.data);
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<RoleModel>> getRole() async {
    try {
      String url = mainUrl + "roles";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<RoleModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(RoleModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<EmployeeModel>> getAllEmployee() async {
    try {
      String url = mainUrl + "employees/all";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<EmployeeModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(EmployeeModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addEmployee({
    required String name,
    required String gender,
    required String img,
    required String email,
    required String dob,
    required String officeTel,
    required String username,
    required String password,
    required String positionId,
    required String departmentId,
    required String phoneNumber,
    required String address,
    required String meritalStatus,
    required String coupleJob,
    required String child,
    required String cardNumber,
    required String nationality,
    required String roleId,
    required String workdayId,
    required String timetalbeId,
  }) async {
    try {
      String url = mainUrl + "employees/add";
      Map body = {
        "name": name,
        "gender": gender,
        "username": username,
        "email": email,
        "dob": dob,
        "office_tel": officeTel,
        "password": password,
        "profile_url": img,
        "position_id": positionId,
        "department_id": departmentId,
        "phone": phoneNumber,
        "address": address,
        "merital_status": meritalStatus,
        "minor_children": child,
        "spouse_job": coupleJob,
        "role_id": roleId,
        "nationality": nationality,
        "card_number": cardNumber,
        "workday_id": workdayId,
        "timetable_id": timetalbeId,
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

  Future<void> editEmployee({
    required String id,
    required String name,
    required String gender,
    required String img,
    required String email,
    required String dob,
    required String officeTel,
    // required String username,
    // required String password,
    required String positionId,
    required String departmentId,
    required String phoneNumber,
    required String address,
    required String meritalStatus,
    required String coupleJob,
    required String child,
    required String cardNumber,
    required String nationality,
    required String roleId,
    required String workdayId,
    required String timetalbeId,
  }) async {
    try {
      String url = mainUrl + "employees/edit/$id";
      Map body = {
        "name": name,
        "gender": gender,
        // "username": username,
        "email": email,
        "dob": dob,
        "office_tel": officeTel,
        // "password": password,
        "profile_url": img,
        "position_id": positionId,
        "department_id": departmentId,
        "phone": phoneNumber,
        "address": address,
        "merital_status": meritalStatus,
        "minor_children": child,
        "spouse_job": coupleJob,
        "role_id": roleId,
        "nationality": nationality,
        "card_number": cardNumber,
        "workday_id": workdayId,
        "timetable_id": timetalbeId,
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

  Future<void> deleteEmployee({
    required String id,
  }) async {
    try {
      String url = mainUrl + "employees/delete/$id";

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

  Future<void> checkin(
      {required String checkinTime, required String employeeId}) async {
    try {
      String url = mainUrl + "checkins/add";
      Map body = {
        "checkin_time": checkinTime,
        "user_id": employeeId,
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

  Future<void> checkout(
      {required String id,
      required String checkoutTime,
      required String employeeId}) async {
    try {
      String url = mainUrl + "checkouts/edit/$id";
      Map body = {
        // "type": "company",
        "checkout_time": checkoutTime,
        "user_id": employeeId,

        // "timetable_id": timetableId
      };

      Response response = await apiProvider.put(
        url,
        body,
      );

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

  Future<String> resetPassword(
      {required String id,
      // required String oldpassowrd,
      required String newpassowrd}) async {
    try {
      String url = mainUrl + "employees/reset-password/$id";
      Map body = {
        // "old_password": oldpassowrd,
        "new_password": newpassowrd,

        // "timetable_id": timetableId
      };

      Response response = await apiProvider.put(
        url,
        body,
      );

      print(response.statusCode);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        print(response.data);
        return response.data["token"];
      } else if (response.data["code"].toString() != "0") {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> resetAdminPassword(
      {required String oldpassowrd, required String newpassowrd}) async {
    try {
      String url = mainUrl + "admins/reset-password";
      Map body = {
        "old_password": oldpassowrd,
        "new_password": newpassowrd,

        // "timetable_id": timetableId
      };

      Response response = await apiProvider.put(
        url,
        body,
      );

      print(response.statusCode);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        print(response.data);
        return UserModel.fromJson(response.data);
      } else if (response.data["code"].toString() != "0") {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}

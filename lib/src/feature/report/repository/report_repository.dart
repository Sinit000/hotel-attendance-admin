import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/report/model/attendance_report_model.dart';
import 'package:hotle_attendnce_admin/src/feature/report/model/employee_report_model.dart';
import 'package:hotle_attendnce_admin/src/feature/report/model/leave_report_model.dart';
import 'package:hotle_attendnce_admin/src/feature/report/model/overtime_report_model.dart';
import 'package:hotle_attendnce_admin/src/feature/report/model/report_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class ReportRepository {
  ApiProvider apiProvider = ApiProvider();
  String mainUrl = "https://banban-hr.herokuapp.com/api/";
  Future<ReportModel> getReport(
      {required String startDate, required String endDate}) async {
    try {
      print(startDate);
      print(endDate);
      String url = mainUrl + "reports?from_date=$startDate&to_date=$endDate";
      Response response = await apiProvider.get(url, null, null);

      if (response.statusCode == 200 && response.data["code"] == 0) {
        return ReportModel.fromJson(response.data);
        // return Report.fromJson(response.data["data"]);
      }

      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<EmployeeReportModel>> getEmployeeReport(
      {required String startDate,
      required String endDate,
      required int page,
      required int rowperpage}) async {
    try {
      String url = mainUrl +
          "employees/reports?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);

      if (response.statusCode == 200) {
        List<EmployeeReportModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(EmployeeReportModel.fromJson(data));
        });
        return leave;
      }

      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<OvertimeReportModel>> getOvertimeReport(
      {required String startDate,
      required String endDate,
      required int page,
      required String id,
      required int rowperpage}) async {
    try {
      String url = mainUrl +
          "overtimes/reports/$id?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);

      if (response.statusCode == 200) {
        List<OvertimeReportModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(OvertimeReportModel.fromJson(data));
        });
        return leave;
      }

      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<LeaveReportModel>> getLeaveReport(
      {required String startDate,
      required String endDate,
      required int page,
      required String id,
      required int rowperpage}) async {
    try {
      String url = mainUrl +
          "leaves/reports/$id?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);

      if (response.statusCode == 200) {
        List<LeaveReportModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(LeaveReportModel.fromJson(data));
        });
        return leave;
      }

      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<AttendanceReportModel>> getAttendanceReport(
      {required String startDate,
      required String endDate,
      required String id,
      required int page,
      required int rowperpage}) async {
    try {
      String url = mainUrl +
          "attendances/reports/$id?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);

      if (response.statusCode == 200) {
        List<AttendanceReportModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(AttendanceReportModel.fromJson(data));
        });
        return leave;
      }

      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}

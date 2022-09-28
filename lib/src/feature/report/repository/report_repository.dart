import 'package:dio/dio.dart';
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
}

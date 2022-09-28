import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/feature/dashboard/model/dashboard_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class DashBoardRepository {
  String mainUrl = "https://banban-hr.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  Future<DashBoardModel> getDashboard() async {
    try {
      String url = mainUrl + "dashboard";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return DashBoardModel.fromJson(response.data);
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotle_attendnce_admin/src/feature/role/model/role_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class RoleRepository {
  String mainUrl = "${dotenv.env['baseUrl']}";
  ApiProvider apiProvider = ApiProvider();
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
}

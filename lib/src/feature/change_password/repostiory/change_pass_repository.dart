import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';


class ChangePasswordRepository {
  ApiProvider apiProvider = ApiProvider();
  String mainUrl = "http://my-attendance-test-demo.herokuapp.com/api/";
  Future<String> changeChangePassword(
      {required String oldpass,
      required String newpass,
      required String username}) async {
    String url = mainUrl + 'profile/change-password';
    Map body = {
      "username": username,
      "old_password": oldpass,
      "new_password": newpass
    };
    try {
      Response response = await apiProvider.put(url, body);
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
}

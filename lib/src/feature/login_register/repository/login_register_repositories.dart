import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/model/user_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class LoginRegisterRepository {
  ApiProvider apiProvider = ApiProvider();
  String mainUrl = "https://banban-hr.herokuapp.com/api/";

  Future<UserModel> login(
      {required String phone, required String password}) async {
    String url = mainUrl + "admin/login";
    Map body = {"email": phone, "password": password};

    var auth = 'Bearer' + base64Encode(utf8.encode('$phone:$password'));
    print(auth);
    try {
      Response response = await apiProvider.post(
          url, body, Options(headers: <String, String>{'authorization': auth}));
      print(response.statusCode);

      if (response.statusCode == 200 && response.data["code"] == 0) {
       
        return UserModel.fromJson(response.data);
      } else if (response.data["code"].toString() != "0") {
      
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (error) {
      throw error;
    }
  }

  Future<UserModel> register(
      {required String name,
      required String phoneNumber,
      required String email,
      required String password}) async {
    try {
      String url = mainUrl + "register";
      Map body = {
        "name": name,
        "phone": phoneNumber,
        "password": password,
        "email": email
      };
      print(phoneNumber);
      Response response = await apiProvider.post(url, body, null);
      if (response.statusCode == 200 && response.data["code"] == 0) {
       
        return UserModel.fromJson(response.data);
        
      } else if (response.data["code"] != 0) {
       
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}

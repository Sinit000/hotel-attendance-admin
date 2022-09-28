import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';


class VerifyOptRepository {
  ApiProvider apiProvider = ApiProvider();
  String mainUrl = "http://opentech.anakutjobs.com/anakut/public/api/";

  Future<void> verifyOpt({required dynamic phone, required dynamic opt}) async {
    try {
      String url = mainUrl + "verify";
      Map body = {
        "phone": phone,
        "otp": opt,
      };
      print(phone);
      print(opt);
      Response response = await apiProvider.post(url, body, null);
      if (response.statusCode == 200 && response.data["code"] == 0) {
        return;
        // return response.data["token"];
      } else if (response.data["code"].toString() != "0") {
        throw response.data["message"];
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> resendOtp({required dynamic phone}) async {
    try {
      String url = mainUrl + "auth/resend";
      Map body = {"phone": phone, "secret": "ANAKUT", "type": "resend"};
      print(phone);
      Response response = await apiProvider.post(url, body, null);
      if (response.statusCode == 200) {
        return;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }
}

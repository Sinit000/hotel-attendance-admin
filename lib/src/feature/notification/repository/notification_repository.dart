import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:hotle_attendnce_admin/src/feature/notification/model/notification_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class NotificationRepository {
  String mainUrl = "${dotenv.env['baseUrl']}";
  ApiProvider apiProvider = ApiProvider();
  Future<List<NotificationModel>> getNotification(
      {required int rowPerpage, required int page}) async {
    try {
      String url = mainUrl + "notifications?page_size=$rowPerpage&page=$page";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<NotificationModel> anounce = [];
        response.data["data"].forEach((data) {
          anounce.add(NotificationModel.fromJson(data));
        });
        return anounce;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addNotification({
    required String title,
    required String des,
    required String date,
    required String time,
    required String userId,
  }) async {
    try {
      String url = mainUrl + "notifications/add";
      Map body = {
        "title": title,
        "body": des,
        "date": date,
        "time": time,
        "user_id": userId
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

  Future<void> editNotification({
    required String id,
    required String title,
    required String des,
    required String date,
    required String time,
    required String userId,
  }) async {
    try {
      String url = mainUrl + "notifications/edit/$id";
      Map body = {
        "title": title,
        "body": des,
        "date": date,
        "time": time,
        "user_id": userId
      };
      print(userId);
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

  Future<void> deleteNotification({
    required String id,
  }) async {
    try {
      String url = mainUrl + "notifications/delete/$id";

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

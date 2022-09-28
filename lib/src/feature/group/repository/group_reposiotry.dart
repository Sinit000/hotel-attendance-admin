import 'package:dio/dio.dart';

import 'package:hotle_attendnce_admin/src/feature/group/model/group_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class GroupRepository {
  String mainUrl = "http://my-attendance-test-demo.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  Future<List<GroupModel>> getGroupList(
      {required int rowPerpage, required int page}) async {
    try {
      String url = mainUrl + "groups?page_size=$rowPerpage&page=$page";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<GroupModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(GroupModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<GroupModel>> getAllgroupList() async {
    try {
      String url = mainUrl + "groups";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<GroupModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(GroupModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addGroup({
    required String name,
    required String notes,
    required String workdayId,
  }) async {
    try {
      String url = mainUrl + "groups/add";
      Map body = {
        "name":name,
        "workday_id":workdayId,
        "notes":notes
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

  Future<void> editGroup({
    required String id,
    required String name,
    required String notes,
    required String workdayId,
  }) async {
    try {
      String url = mainUrl + "groups/edit/$id";
      Map body = {
        "name":name,
        "workday_id":workdayId,
        "notes":notes
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

  Future<void> deleteGroup({
    required String id,
  }) async {
    try {
      String url = mainUrl + "groups/delete/$id";

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

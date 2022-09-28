import 'package:dio/dio.dart';
import 'package:hotle_attendnce_admin/src/feature/account/model/account_model.dart';
import 'package:hotle_attendnce_admin/src/feature/location/models/location_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class LocationRepository {
  String mainUrl = "https://banban-hr.herokuapp.com/api/";
  ApiProvider apiProvider = ApiProvider();
  Future<List<LocationModel>> getLocationList(
      {required int rowPerpage, required int page}) async {
    try {
      String url = mainUrl + "locations?page_size=$rowPerpage&page=$page";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<LocationModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(LocationModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<LocationModel>> getAllLocation() async {
    try {
      String url = mainUrl + "locations/all";

      Response response = await apiProvider.get(url, null, null);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        List<LocationModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(LocationModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addLocation({
    required String name,
    required String notes,
    required String lat,
    required String lon,
    required String addressDetail,
  }) async {
    try {
      String url = mainUrl + "locations/add";
      Map body = {
        "name": name,
        "lat": lat,
        "lon": lon,
        "address_detail": addressDetail,
        "notes": notes
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

  Future<void> editWorkday({
    required String id,
    required String name,
    required String notes,
    required String lat,
    required String lon,
    required String addressDetail,
  }) async {
    try {
      String url = mainUrl + "locations/edit/$id";
      Map body = {
        "name": name,
        "lat": lat,
        "lon": lon,
        "address_detail": addressDetail,
        "notes": notes
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

  Future<void> deleteLocation({
    required String id,
  }) async {
    try {
      String url = mainUrl + "locations/delete/$id";

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

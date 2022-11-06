import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotle_attendnce_admin/src/feature/counter/model/checkin_history_model.dart';
import 'package:hotle_attendnce_admin/src/feature/counter/model/counter_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class CounterRepository {
  ApiProvider apiProvider = ApiProvider();
  String mainUrl = "${dotenv.env['baseUrl']}";
  Future<List<CounterModel>> getCounter(
      {required int page, required int rowperpage}) async {
    try {
      String url = mainUrl + "counters?page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);

      if (response.statusCode == 200) {
        List<CounterModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(CounterModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<List<CheckinHistoryModel>> getCheckinHistory(
      {required int page, required int rowperpage}) async {
    try {
      String url =
          mainUrl + "checkins/histories?page_size=$rowperpage&page=$page";
      Response response = await apiProvider.get(url, null, null);

      if (response.statusCode == 200) {
        List<CheckinHistoryModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(CheckinHistoryModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> editCounter(
      {required String id,
      required String userId,
      required String ot,
      required String ph,
      required String hospitalLeave,
      required String marriageLeave,
      required String peternityLeave,
      required String funeralLeave,
      required String maternityLeave}) async {
    try {
      print(id);
      String url = mainUrl + "counters/edit/$id";
      print(userId);
      print(ot);
      print(ph);
      print(hospitalLeave);
      print(marriageLeave);
      Map body = {
        "user_id": userId,
        "ot_duration": ot,
        "total_ph": ph,
        "hospitality_leave": hospitalLeave,
        "marriage_leave": marriageLeave,
        "peternity_leave": peternityLeave,
        "funeral_leave": funeralLeave,
        "maternity_leave": maternityLeave
      };

      Response response = await apiProvider.put(
        url,
        body,
      );

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

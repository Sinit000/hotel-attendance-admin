import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/model/payslip_model.dart';
import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:hotle_attendnce_admin/src/utils/service/custome_exception.dart';

class PayslipRepository {
  String mainUrl = "${dotenv.env['baseUrl']}";
  ApiProvider _apiProvider = ApiProvider();
  Future<List<PayslipModel>> getPayslip(
      {required int rowperpage,
      required int page,
      required String startDate,
      required String endDate}) async {
    try {
      String url =
          "${dotenv.env['baseUrl']}payslips?from_date=$startDate&to_date=$endDate&page_size=$rowperpage&page=$page";
      print(url);
      Response response = await _apiProvider.get(url, null, null);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.data);
        List<PayslipModel> leave = [];
        response.data["data"].forEach((data) {
          leave.add(PayslipModel.fromJson(data));
        });
        return leave;
      }
      throw CustomException.generalException();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addPayslip({
    required String userId,
    // required String contractId,
    required String fromDate,
    required String toDate,
    required String allowance,
    required String bonus,
    required String senioritySalary,
    required String advanceMoney,
    required String currey,
    required String exChangeRate,
    required String deduction,
  }) async {
    try {
      String url = mainUrl + "payslips/add";
      Map body = {
        "user_id": userId,
        // "contract_id": contractId,
        "from_date": fromDate,
        "to_date": toDate,
        "allowance": allowance,
        "bonus": bonus,
        "senority_salary": senioritySalary,
        "advance_salary": advanceMoney,
        "currency": currey,
        "exchange_rate": exChangeRate,
        "deduction": deduction,
      };
      Response response = await _apiProvider.post(url, body, null);

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

  Future<void> editPayslip({
    required String id,
    required String userId,
    // required String contractId,
    required String fromDate,
    required String toDate,
    required String allowance,
    required String bonus,
    required String senioritySalary,
    required String advanceMoney,
    required String currey,
    required String exChangeRate,
    required String deduction,
  }) async {
    try {
      String url = mainUrl + "payslips/edit/$id";
      Map body = {
        "user_id": userId,
        // "contract_id": contractId,
        "from_date": fromDate,
        "to_date": toDate,
        "allowance": allowance,
        "bonus": bonus,
        "senority_salary": senioritySalary,
        "advance_salary": advanceMoney,
        "currency": currey,
        "exchange_rate": exChangeRate,
        "deduction": deduction,
      };
      Response response = await _apiProvider.put(url, body);

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

  Future<void> deletePayslip({
    required String id,
  }) async {
    try {
      String url = mainUrl + "payslips/delete/$id";

      Response response = await _apiProvider.delete(url, null);
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

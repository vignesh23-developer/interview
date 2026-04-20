import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/api_contants.dart';
import '../core/services/api_services.dart';
import '../model/cash_register.dart';

class CashRegisterController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;
  var cashData = Rxn<CashRegisterModel>();

  Future<void> createCashRegister(int locationId) async {
    isLoading.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("access_token");

      print(" TOKEN => $token");

      final body = {"amount": 100, "location_id": locationId};

      print("REQUEST BODY => $body");

      final response = await _apiService.post(
        ApiConstants.create,
        body,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      print("RESPONSE => ${response.data}");

      final data = response.data['data'];
      cashData.value = CashRegisterModel.fromJson(data);

      print("SUCCESS ID => ${cashData.value?.id}");
    } catch (e) {
      print("❌ ERROR OCCURRED => $e");
    } finally {
      isLoading.value = false;
    }
  }
}

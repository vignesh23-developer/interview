import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

import '../core/constants/api_contants.dart';
import '../core/constants/shared_preference.dart';
import '../core/services/api_services.dart';
import '../model/cash_register.dart';
import '../model/placeOrderModel.dart';
import '../view/order_placed_screen.dart';

class CashRegisterController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;
  var cashData = Rxn<CashRegisterModel>();

  var qty = 1.obs;

  var isPlacingOrder = false.obs;
  var placeOrderData = Rxn<PlaceOrderModel>();

  Future<void> createCashRegister(int locationId) async {
    isLoading.value = true;

    try {
      final token = SharedPrefService.getToken();

      final body = {"amount": 100, "location_id": locationId};

      final response = await _apiService.post(
        ApiConstants.create,
        body,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      final data = response.data['data'];
      cashData.value = CashRegisterModel.fromJson(data);
    } catch (e) {
      print("CREATE ERROR => $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> placeOrder(int locationId) async {
    isPlacingOrder.value = true;

    try {
      final token = SharedPrefService.getToken();

      final body = {
        "is_enabled_stock": 1,
        "location_id": locationId,
        "contact_id": 1,
        "price_group": 0,
        "sell_price_tax": "includes",
        "products": [
          {
            "product_type": "single",
            "unit_price": 3.84,
            "line_discount_type": "fixed",
            "line_discount_amount": 0.0,
            "item_tax": 0.0,
            "tax_id": null,
            "sell_line_note": null,
            "product_id": 38,
            "variation_id": 54,
            "enable_stock": 1,
            "variation_double_id": null,
            "quantity": qty.value.toDouble(),
            "base_unit_multiplier": 1,
            "unit_price_inc_tax": 3.84,
          },
        ],
        "payment": [
          {"method": "cash", "amount": 5.00},
          {"method": "custom_pay_1", "amount": 13.50},
        ],
        "final_total": 18.5,
        "status": "final",
      };

      final response = await _apiService.post(
        ApiConstants.placeOrder,
        body,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      final res = response.data;
      final data = res['data'] ?? res;

      if (data != null && data is Map<String, dynamic>) {
        placeOrderData.value = PlaceOrderModel.fromJson(data);

        Get.to(() => OrderSuccessScreen(order: placeOrderData.value!));
      }
    } catch (e) {
      print("ORDER ERROR => $e");
    } finally {
      isPlacingOrder.value = false;
    }
  }
}

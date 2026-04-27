// import 'package:dio/dio.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../core/constants/api_contants.dart';
// import '../core/services/api_services.dart';
// import '../model/placeOrderModel.dart';
//
// var placeOrderData = Rxn<PlaceOrderModel>();
// var isPlacingOrder = false.obs;
// final ApiService _apiService = ApiService();
//
// Future<void> placeOrder(int locationId, int qty) async {
//   isPlacingOrder.value = true;
//
//   try {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString("access_token");
//
//     final body = {
//       "is_enabled_stock": 1,
//       "location_id": locationId,
//       "contact_id": 1,
//       "price_group": 0,
//       "sell_price_tax": "includes",
//
//       "products": [
//         {
//           "product_type": "single",
//           "unit_price": 3.84,
//           "line_discount_type": "fixed",
//           "line_discount_amount": 0.0,
//           "item_tax": 0.0,
//           "tax_id": null,
//           "sell_line_note": null,
//           "product_id": 38,
//           "variation_id": 54,
//           "enable_stock": 1,
//           "variation_double_id": null,
//           "quantity": qty.toDouble(), // ✅ dynamic qty
//           "base_unit_multiplier": 1,
//           "unit_price_inc_tax": 3.84
//         }
//       ],
//
//       "advance_balance": 0.0,
//
//       "payment": [
//         {"method": "cash", "amount": 5.00},
//         {"method": "custom_pay_1", "amount": 13.50}
//       ],
//
//       "change_return": 0.00,
//       "is_withdraw": 0,
//       "is_suspend": 0,
//       "recur_interval_type": "days",
//       "final_total": 18.5,
//       "is_credit_sale": 0,
//       "discount_type": "",
//       "discount_amount": 0.0,
//       "rp_redeemed": 0,
//       "rp_redeemed_amount": 0,
//       "tax_rate_id": 1,
//       "tax_calculation_amount": 5.0,
//       "shipping_charges": 0.0,
//       "discount_type_modal": "",
//       "discount_amount_modal": 0.0,
//       "order_tax_modal": 1,
//       "shipping_charges_modal": 0,
//       "status": "final"
//     };
//
//     final response = await _apiService.post(
//       ApiConstants.placeOrder,
//       body,
//       options: Options(headers: {"Authorization": "Bearer $token"}),
//     );
//
//     final data = response.data['data'];
//
//     placeOrderData.value = PlaceOrderModel.fromJson(data);
//
//     print("✅ ORDER SUCCESS ID: ${placeOrderData.value?.id}");
//
//   } catch (e) {
//     print("❌ PLACE ORDER ERROR => $e");
//   } finally {
//     isPlacingOrder.value = false;
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import '../core/constants/api_contants.dart';
import '../core/services/api_services.dart';
import '../model/login_model.dart';
import '../view/dashboard_screen.dart';

class AuthController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var locations = <LocationModel>[].obs;

  Future<void> login() async {
    isLoading.value = true;

    try {
      final response = await _apiService.post(ApiConstants.login, {
        "username": usernameController.text,
        "password": passwordController.text,
      });

      final data = LoginResponse.fromJson(response.data);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("access_token", data.accessToken);

      locations.assignAll(data.locations);

      toastification.show(
        context: Get.context!,
        title: const Text("Login Successful"),
        type: ToastificationType.success,
      );

      Get.off(() => DashboardScreen());
    } catch (e) {
      toastification.show(
        context: Get.context!,
        title: const Text("Login Failed"),
        type: ToastificationType.error,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

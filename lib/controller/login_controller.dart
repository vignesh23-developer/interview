import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import '../core/constants/api_contants.dart';
import '../core/constants/shared_preference.dart';
import '../core/services/api_services.dart';
import '../model/login_model.dart';
import '../view/dashboard_screen.dart';

class AuthController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var locations = <LocationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedLocations();
  }

  void loadSavedLocations() {
    final locString = SharedPrefService.getString("locations");

    if (locString != null && locString.isNotEmpty) {
      final list = LoginResponse.locationsFromJson(locString);
      locations.assignAll(list);

      print("LOADED LOCATIONS COUNT: ${locations.length}");
    }
  }

  Future<void> login() async {
    isLoading.value = true;

    try {
      final response = await _apiService.post(ApiConstants.login, {
        "username": usernameController.text.trim(),
        "password": passwordController.text.trim(),
      });

      if (response.statusCode == 200) {
        final data = LoginResponse.fromJson(response.data);


        await SharedPrefService.setToken(data.accessToken);


        await SharedPrefService.setString(
          "locations",
          LoginResponse.locationsToJson(data.locations),
        );


        locations.assignAll(data.locations);

        toastification.show(
          context: Get.context!,
          title: const Text("Login Successful"),
          type: ToastificationType.success,
        );

        Get.off(() => DashboardScreen());
      } else {
        throw Exception("Login failed");
      }
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
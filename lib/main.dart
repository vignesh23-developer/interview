import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interview/view/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:interview/view/login_screen.dart';

import 'controller/login_controller.dart';
import 'core/constants/shared_preference.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefService.init();
  final token = SharedPrefService.getToken();
  Get.put(AuthController());
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return ToastificationWrapper(
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
              ),
              useMaterial3: true,
            ),
            home: token != null && token!.isNotEmpty
                ? DashboardScreen()
                : LoginScreen(),
          ),
        );
      },
    );
  }
}
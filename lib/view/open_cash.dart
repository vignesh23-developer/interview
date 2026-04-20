import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/create_controller.dart';

class ViewProductScreen extends StatelessWidget {
  final int locationId;

  ViewProductScreen({super.key, required this.locationId});

  final CashRegisterController controller = Get.put(CashRegisterController());

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => controller.createCashRegister(locationId));

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Cash Register",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: SizedBox(
              width: 30.w,
              height: 30.w,
              child: const CircularProgressIndicator(),
            ),
          );
        }

        if (controller.cashData.value == null) {
          return Center(
            child: Text("No Data Found", style: TextStyle(fontSize: 14.sp)),
          );
        }

        final data = controller.cashData.value!;

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Register ID",
                      style: TextStyle(fontSize: 12.sp, color: Colors.white70),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "#${data.id}",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12.h),


                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        data.status.toUpperCase(),
                        style: TextStyle(fontSize: 11.sp, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),


              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _tile(
                      Icons.location_on,
                      "Location ID",
                      data.locationId.toString(),
                    ),

                    Divider(height: 20.h),

                    _tile(Icons.production_quantity_limits, "Product ID", data.id.toString()),

                    Divider(height: 20.h),

                    _tile(
                      Icons.signal_wifi_statusbar_4_bar,
                      "Status",
                      data.status.toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _tile(IconData icon, String title, String value) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, size: 18.sp, color: Colors.blue),
        ),
        SizedBox(width: 12.w),

        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
        ),

        Text(
          value,
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

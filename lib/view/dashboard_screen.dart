import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';
import 'open_cash.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final AuthController controller = Get.find();
  final RxString searchText = "".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: Text(
          "Products",
          style: TextStyle(fontSize: 18.sp),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Container(
              height: 45.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  )
                ],
              ),
              child: TextField(
                onChanged: (value) {
                  searchText.value = value.toLowerCase();
                },
                decoration: InputDecoration(
                  hintText: "Search location...",
                  hintStyle: TextStyle(fontSize: 14.sp),
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ),
          ),

          Expanded(
            child: Obx(() {
              final filteredList = controller.locations
                  .where((e) =>
              e.name.toLowerCase().contains(searchText.value) ||
                  e.city.toLowerCase().contains(searchText.value))
                  .toList();

              if (filteredList.isEmpty) {
                return Center(
                  child: Text(
                    "No Locations Found",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final location = filteredList[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: 14.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.06),
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(18.r),
                          ),
                          child: Stack(
                            children: [
                              Image.network(
                                location.image ?? "",
                                height: 150.h,
                                width: 900.w,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  height: 150.h,
                                  width: 900.w,
                                  color: Colors.grey.shade300,
                                  child: const Icon(Icons.image, size: 40),
                                ),
                              ),

                              Positioned(
                                top: 10.h,
                                right: 10.w,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    "Active",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),


                        Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                location.name,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                              SizedBox(height: 6.h),

                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      size: 14.sp, color: Colors.blue),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: Text(
                                      location.city,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[700],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 4.h),

                              Text(
                                "${location.state}, ${location.country}",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.grey[500],
                                ),
                              ),

                              SizedBox(height: 10.h),

                              SizedBox(
                                width: double.infinity,
                                height: 38.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(() => ViewProductScreen(locationId: location.id));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.r),
                                    ),
                                  ),
                                  child: Text(
                                    "Open Cash Register",
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
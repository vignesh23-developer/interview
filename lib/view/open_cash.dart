import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controller/create_controller.dart';

class ViewProductScreen extends StatefulWidget {
  final int locationId;

  const ViewProductScreen({super.key, required this.locationId});

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  final CashRegisterController controller =
  Get.put(CashRegisterController());

  @override
  void initState() {
    super.initState();
    controller.createCashRegister(widget.locationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        elevation: 0,
        title: Text("Cash Register", style: TextStyle(fontSize: 16.sp)),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.cashData.value;
        if (data == null) {
          return const Center(child: Text("No Data Found"));
        }

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
                    Text("Register ID",
                        style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 6.h),
                    Text(
                      "#${data.id}",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: data.status == "open"
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        data.status.toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              _card([
                _tile(Icons.location_on, "Location ID",
                    data.locationId.toString()),
                _tile(Icons.qr_code, "Register ID", data.id.toString()),
                _tile(Icons.info, "Status", data.status),
              ]),
              SizedBox(height: 16.h),
              _card([
                Text("Quantity", style: TextStyle(fontSize: 14.sp)),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (controller.qty.value > 1) {
                          controller.qty.value--;
                        }
                      },
                      icon: const Icon(Icons.remove_circle),
                      color: Colors.red,
                    ),
                    Obx(() => Text(
                      controller.qty.value.toString(),
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold),
                    )),
                    IconButton(
                      onPressed: () {
                        controller.qty.value++;
                      },
                      icon: const Icon(Icons.add_circle),
                      color: Colors.green,
                    ),
                  ],
                ),
              ]),
              // SizedBox(height: 16.h),
              // Obx(() {
              //   if (controller.isPlacingOrder.value) {
              //     return const CircularProgressIndicator();
              //   }
              //
              //   final order = controller.placeOrderData.value;
              //   if (order == null) return const SizedBox();
              //
              //   return Container(
              //     width: double.infinity,
              //     padding: EdgeInsets.all(20.w),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20.r),
              //       color: Colors.white,
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black.withOpacity(0.05),
              //           blurRadius: 10,
              //         )
              //       ],
              //     ),
              //     child: Column(
              //       children: [
              //
              //
              //         SizedBox(
              //           height: 120.h,
              //           child: Lottie.asset("assets/Success.json"),
              //         ),
              //
              //         SizedBox(height: 10.h),
              //
              //         Text(
              //           "Order Placed Successfully",
              //           style: TextStyle(
              //             fontSize: 16.sp,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.green,
              //           ),
              //         ),
              //
              //         SizedBox(height: 10.h),
              //
              //         Text("Order ID: ${order.id}"),
              //         Text("Status: ${order.status}"),
              //         Text(
              //           "Total: ₹${order.finalTotal}",
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 14.sp,
              //           ),
              //         ),
              //
              //         SizedBox(height: 12.h),
              //
              //         Container(
              //           padding: EdgeInsets.symmetric(
              //             horizontal: 12.w,
              //             vertical: 6.h,
              //           ),
              //           decoration: BoxDecoration(
              //             color: Colors.green,
              //             borderRadius: BorderRadius.circular(20.r),
              //           ),
              //           child: Text(
              //             "SUCCESS",
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 12.sp,
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   );
              // })
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        final isLoading = controller.isPlacingOrder.value;

        return Container(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, -3),
              )
            ],
          ),
          child: GestureDetector(
            onTap: isLoading
                ? null
                : () {
              controller.placeOrder(widget.locationId);
            },
            child: Container(
              height: 55.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                gradient: const LinearGradient(
                  colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                ),
              ),
              child: Center(
                child: isLoading
                    ? SizedBox(
                  height: 22.h,
                  width: 22.h,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_bag,
                        color: Colors.white),
                    SizedBox(width: 8.w),
                    Text(
                      "Place Order (Qty: ${controller.qty.value})",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _card(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
      ),
      child: Column(children: children),
    );
  }

  Widget _tile(IconData icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 10.w),
          Expanded(child: Text(title)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
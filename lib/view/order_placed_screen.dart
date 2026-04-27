import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../model/placeOrderModel.dart';

class OrderSuccessScreen extends StatelessWidget {
  final PlaceOrderModel order;

  const OrderSuccessScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text("Order Success"),
        centerTitle: true,
      ),

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.05),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [


                SizedBox(
                  height: 150.h,
                  child: Lottie.asset("assets/Success.json"),
                ),

                SizedBox(height: 16.h),

                Text(
                  "Order Placed Successfully",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),

                SizedBox(height: 16.h),


                _row("Order ID", order.id.toString()),
                _row("Status", order.status ?? "-"),
                _row("Total", "₹${order.finalTotal ?? 0}"),

                SizedBox(height: 20.h),


                SizedBox(
                  width: double.infinity,
                  height: 45.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Back"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
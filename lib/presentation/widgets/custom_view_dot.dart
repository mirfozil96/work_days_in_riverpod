import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomViewDot extends StatelessWidget {
  final int pageIndex;
  final int index;

  const CustomViewDot({super.key, required this.pageIndex, required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: pageIndex == index ? 9.0.h : 9.0.h,
      width: pageIndex == index ? 28.0.w : 9.0.w,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: pageIndex == index ? const Color(0xffFD6B22) : const Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
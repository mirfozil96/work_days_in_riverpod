import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rbc_control/core/constants/app_text_styles.dart';

class CustomAuthTitle extends StatelessWidget{
  final String title;
  final String subTitle;
  final EdgeInsetsGeometry? padding;
  const CustomAuthTitle({
    super.key,
    required this.title,
    required this.subTitle, 
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding?? EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles().headline1,
          ),
          SizedBox(height: 18.h),
          Text(
            subTitle,
            style: AppTextStyles().headlineSubtitle,
          ),
        ],
      ),
    );
  }
}
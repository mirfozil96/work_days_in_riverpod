import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rbc_control/core/constants/app_colors.dart';

@immutable
final class AppTextStyles{

  TextStyle? get headline1 => TextStyle(
      fontFamily: "DM Sans",
      fontWeight: FontWeight.w700,
      fontSize: 35.sp,
      // height: 46,
      letterSpacing: -1.6,
      color: AppColors.c1B1D21,
  );

  TextStyle? get headline4 => TextStyle(
      fontFamily: "DM Sans",
      fontWeight: FontWeight.w700,
      fontSize: 18.sp,
      letterSpacing: -0.4,
      color: AppColors.c1B1D21,
  );

  TextStyle? get headline4Medium => TextStyle(
    fontFamily: "DM Sans",
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    letterSpacing: -0.3,
    color: AppColors.c040415,
  );

  TextStyle? get headline6 => TextStyle(
    fontFamily: "DM Sans",
    fontWeight: FontWeight.w700,
    fontSize: 14.sp,
    letterSpacing: -0.3,
    color: AppColors.white,
  );

  TextStyle? get headlineSubtitle => TextStyle(
    fontFamily: "DM Sans",
    fontWeight: FontWeight.w400,
    fontSize: 24.sp,
    letterSpacing: -0.8,
    color: AppColors.black50,
  );

  TextStyle? get paragraph => TextStyle(
    fontFamily: "DM Sans",
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    letterSpacing: -0.36,
    color: AppColors.black50,
  );

  TextStyle? get paragraph3 => TextStyle(
    fontFamily: "DM Sans",
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    letterSpacing: -0.3,
    color: AppColors.c040415,
  );

  TextStyle? get labelStyle => TextStyle(
    fontFamily: "DM Sans",
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    letterSpacing: -0.2,
    color: AppColors.labelColor,
  );

  TextStyle? get grayBoldLabel => TextStyle(
    fontFamily: "DM Sans",
    fontWeight: FontWeight.w700,
    fontSize: 12.sp,
    letterSpacing: 1,
    color: AppColors.c8F92A1,
  );
}
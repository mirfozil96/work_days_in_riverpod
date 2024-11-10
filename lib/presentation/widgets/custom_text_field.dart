import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyBoardType;
  final TextInputAction textInputAction;
  final bool? obscureText;
  final IconButton? suffixIcon;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyBoardType,
    this.obscureText,
    required this.labelText,
    required this.textInputAction,
    this.suffixIcon,
    this.validator,
    this.onTap, 
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding?? EdgeInsets.symmetric(vertical: 12.h),
      child: TextFormField(
        controller: controller,
        keyboardType: keyBoardType,
        obscureText: obscureText ?? false,
        textInputAction: textInputAction,
        validator: validator,
        style: const TextStyle(
          color: AppColors.black,
        ),
        cursorColor: AppColors.fD6B22,
        decoration: InputDecoration(
          errorMaxLines: 2,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.lFF0000,
            ),
          ),
          // labelStyle:  TextStyles()
          //     .onlineRecordTitleLarge
          //     ?.copyWith(color: AppColors.lC1C1C1),
          // floatingLabelStyle:
          //    TextStyles().subText?.copyWith(fontSize: 19),
          label: Text(labelText),
          hintText: hintText,
          //   hintStyle:  TextStyles().hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.lD9D9D9,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.lD9D9D9,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.fD6B22,
              width: 1,
            ),
          ),
          // labelStyle: TextStyle(),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

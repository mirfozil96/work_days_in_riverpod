import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rbc_control/core/constants/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  final EdgeInsetsGeometry? padding;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed, 
    this.backgroundColor, 
    this.textColor, 
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 12.h),
      child: MaterialButton(
        onPressed: onPressed,
        color: backgroundColor ?? const Color(0xffFD6B22),
        minWidth: double.infinity,
        height: 56.h,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Text(
          text,
          style: AppTextStyles().headline6?.copyWith(
            color: textColor
          ),
        ),
      ),
    );
  }
}
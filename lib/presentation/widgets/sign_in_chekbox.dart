import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rbc_control/core/constants/app_colors.dart';
import 'package:rbc_control/presentation/widgets/custom_rich_text_widget.dart';

class Logincheckbox extends StatelessWidget {
  final bool checkbox;
  final String text;
  final double? textSize;
  final FontWeight? textFontWeight;

  final double? navigateTextSize;
  final FontWeight? navigateTextFontWeight;
  final void Function() onPressedButton;
  final void Function()? onTapText;
  final EdgeInsetsGeometry? padding;

  const Logincheckbox({
    super.key,
    required this.checkbox,
    required this.text,
    this.textSize,
    this.textFontWeight,
    this.navigateTextSize,
    this.navigateTextFontWeight,
    this.onTapText,
    this.padding,
    required this.onPressedButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          IconButton(
            highlightColor: Colors.transparent,
            onPressed: onPressedButton,
            icon: checkbox == true
                ? const Icon(
                    Icons.check_box,
                    color: AppColors.cFD6B22,
                  )
                : const Icon(
                    Icons.check_box_outline_blank_rounded,
                    color: AppColors.cF4F5F7,
                  ),
          ),
          CustomRichText(
            text: text,
            textFontWeight: textFontWeight ?? FontWeight.w400,
            textSize: textSize ?? 15.sp,
            navigateTextFontWeight: navigateTextFontWeight ?? FontWeight.w400,
            navigateTextSize: navigateTextSize ?? 12.sp,
            onTap: onTapText,
            textColor: Colors.black, // Matn rangini kiriting
          )
        ],
      ),
    );
  }
}

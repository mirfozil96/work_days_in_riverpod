import 'package:flutter/material.dart';
import 'package:rbc_control/core/constants/app_colors.dart';
import 'package:rbc_control/core/constants/app_text_styles.dart';

class CustomAppbarWidget extends StatelessWidget implements PreferredSizeWidget{
  final Color? backgroundColor;
  final Color? textColor;
  final String? title;

  const CustomAppbarWidget({
    super.key,
    this.backgroundColor,
    this.title, 
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor??AppColors.white,
      title: Text(title??"",
        style: AppTextStyles().headline4?.copyWith(
          color: textColor??AppColors.black
        ),
      ),
      centerTitle: true,
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

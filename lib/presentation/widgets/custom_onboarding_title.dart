import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_text_styles.dart';

class CustomOnboardingTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  const CustomOnboardingTitle({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles().headline1,
        ),
        SizedBox(height: 18.h),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: AppTextStyles().paragraph,
        ),
      ],
    );
  }
}

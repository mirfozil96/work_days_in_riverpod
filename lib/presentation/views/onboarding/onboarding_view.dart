import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rbc_control/presentation/widgets/custom_button.dart';
import 'package:rbc_control/presentation/widgets/custom_onboarding_title.dart';
import 'package:rbc_control/presentation/widgets/custom_onboarding_container_one.dart';
import 'package:rbc_control/presentation/widgets/custom_onboarding_container_three.dart';
import 'package:rbc_control/presentation/widgets/custom_onboarding_container_two.dart';
import 'package:rbc_control/presentation/widgets/custom_view_dot.dart';
import 'package:rbc_control/routes/app_route_name.dart';
import '../../viewmodels/onboarding_viewmodel.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingViewModelProvider);
    final onboardingViewModel = ref.read(onboardingViewModelProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onboardingViewModel.onPageChanged(context, onboardingState.pageIndex);
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 412.h,
            width: double.infinity,
            child: PageView(
              controller: onboardingState.pageController,
              onPageChanged: (index) => onboardingViewModel.onPageChanged(context, index),
              children: const [
                CustomOnboardingContainerOne(),
                CustomOnboardingContainerTwo(),
                CustomOnboardingContainerThree(),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomOnboardingTitle(
                    title: onboardingState.title,
                    subTitle: onboardingState.subTitle,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 9.h,
                          width: 56.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomViewDot(
                                  pageIndex: onboardingState.pageIndex,
                                  index: 0),
                              CustomViewDot(
                                  pageIndex: onboardingState.pageIndex,
                                  index: 1),
                              CustomViewDot(
                                  pageIndex: onboardingState.pageIndex,
                                  index: 2),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        CustomButton(
                          text: "Next",
                          onPressed: () {
                            onboardingState.isFinal == true
                                ? context.go(AppRouteName.login)
                                : onboardingState.pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn,
                                  );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

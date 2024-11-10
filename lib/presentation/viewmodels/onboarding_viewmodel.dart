import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rbc_control/l10n/app_localizations.dart';

final onboardingViewModelProvider = StateNotifierProvider<OnboardingViewModel, OnboardingState>((ref) {
  return OnboardingViewModel();
});

class OnboardingState {
  final int pageIndex;
  final String title;
  final String subTitle;
  final bool isFinal;
  final PageController pageController;

  OnboardingState({
    required this.pageIndex,
    required this.title,
    required this.subTitle,
    required this.isFinal,
    required this.pageController,
  });

  OnboardingState copyWith({
    int? pageIndex,
    String? title,
    String? subTitle,
    bool? isFinal,
    PageController? pageController,
  }) {
    return OnboardingState(
      pageIndex: pageIndex ?? this.pageIndex,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      isFinal: isFinal ?? this.isFinal,
      pageController: pageController ?? this.pageController,
    );
  }
}

class OnboardingViewModel extends StateNotifier<OnboardingState> {
  OnboardingViewModel() : super(OnboardingState(
      pageIndex: 0,
      title: "",
      subTitle: "",
      isFinal: false,
      pageController: PageController(),
    ));

  void onPageChanged(BuildContext context, int index) {
    String title;
    String subTitle;
    bool isFinal;

    if (index == 0) {
      title = AppLocalizations.of(context)!.onboardingTitleOne;
      subTitle = AppLocalizations.of(context)!.onboardingSubTitleOne;
      isFinal = false;
    } else if (index == 1) {
      title = AppLocalizations.of(context)!.onboardingTitleTwo;
      subTitle = AppLocalizations.of(context)!.onboardingSubTitleTwo;
      isFinal = false;
    } else if (index == 2) {
      title = AppLocalizations.of(context)!.onboardingTitleThree;
      subTitle = AppLocalizations.of(context)!.onboardingSubTitleThree;
      isFinal = true;
    } else {
      title = "";
      subTitle = "";
      isFinal = false;
    }

    state = state.copyWith(
      pageIndex: index,
      title: title,
      subTitle: subTitle,
      isFinal: isFinal,
    );
  }

  @override
  void dispose() {
    state.pageController.dispose();
    super.dispose();
  }
}

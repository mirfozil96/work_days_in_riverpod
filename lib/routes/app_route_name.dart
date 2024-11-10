import "package:flutter/foundation.dart";

@immutable
final class AppRouteName {
  const AppRouteName._();

  static const String welcomeMobile = "/welcome_mobile_page";
  static const String otpVerification = "otp_verification_page";
  static const String onboarding = "/onboarding_page";
  static const String register = "register_page";
  static const String login = "/login_page";
  static const String forgetPassword = "forget_password_page";
  static const String forgetPasswordResetEmail = "forget_password_reset_page";
  static const String setANewPassword = "set_new_password_page";

  static const String home = "/home_page";
  static const String profile = "/profile_wiev";
  static const String splashPage = "/splash_screen";
}

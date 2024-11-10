import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:rbc_control/presentation/views/auth/forget_password_page.dart";
import "package:rbc_control/presentation/views/auth/forget_password_reset_page.dart";
import "package:rbc_control/presentation/views/auth/login_page.dart";
import "package:rbc_control/presentation/views/auth/register_page.dart";
import "package:rbc_control/presentation/views/auth/set_new_password_page.dart";
import "package:rbc_control/presentation/views/onboarding/onboarding_view.dart";
import "package:rbc_control/presentation/views/welcome/otp_verification_page.dart";
import "package:rbc_control/presentation/views/welcome/welcome_mobile_page.dart";
import "../presentation/views/home/home_page.dart";
import "../presentation/views/navigation_screen.dart";
import "../presentation/views/profile/profile_view.dart";
import "../presentation/views/splash_screen.dart";
import "app_route_name.dart";

final class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRouteName.onboarding,
    routes: <RouteBase>[
      GoRoute(
        path: AppRouteName.splashPage,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashPage(),
      ),

      /// Welcome
      GoRoute(
        path: AppRouteName.welcomeMobile,
        builder: (BuildContext context, GoRouterState state) =>
            const WelcomeMobilePage(),
        routes: [
          GoRoute(
            path: AppRouteName.otpVerification,
            builder: (BuildContext context, GoRouterState state) =>
                const OtpVerificationPage(),
          ),
        ],
      ),

      /// Onboarding
      GoRoute(
        path: AppRouteName.onboarding,
        builder: (BuildContext context, GoRouterState state) =>
            const OnboardingView(),
      ),

      /// login
      GoRoute(
        path: AppRouteName.login,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginPage(),
        routes: [
          GoRoute(
            path: AppRouteName.register,
            builder: (BuildContext context, GoRouterState state) =>
                const RegisterPage(),
          ),
          GoRoute(
            path: AppRouteName.forgetPassword,
            builder: (BuildContext context, GoRouterState state) =>
                const ForgetPasswordPage(),
            routes: [
              GoRoute(
                path: AppRouteName.forgetPasswordResetEmail,
                builder: (BuildContext context, GoRouterState state) =>
                    const ForgetPasswordResetPage(),
                routes: [
                  GoRoute(
                    path: AppRouteName.setANewPassword,
                    builder: (BuildContext context, GoRouterState state) =>
                        const SetNewPasswordPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      //main

      ShellRoute(
        builder: (context, state, child) => PrimaryPage(child),
        routes: [
          GoRoute(
            path: AppRouteName.home,
            builder: (BuildContext context, GoRouterState state) =>
                const HomePage(),
          ),
          GoRoute(
            path: AppRouteName.profile,
            builder: (BuildContext context, GoRouterState state) =>
                const ProfilePage(),
          ),
        ],
      ),
    ],
  );
}

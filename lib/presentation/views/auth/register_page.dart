import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rbc_control/core/constants/app_colors.dart';
import 'package:rbc_control/core/utils/utils.dart';
import 'package:rbc_control/data/datasources/auth_methods.dart';
import 'package:rbc_control/presentation/widgets/custom_appbar_widget.dart';
import 'package:rbc_control/presentation/widgets/custom_auth_title.dart';
import 'package:rbc_control/presentation/widgets/custom_button.dart';
import 'package:rbc_control/presentation/widgets/custom_register_checkbox.dart';
import 'package:rbc_control/presentation/widgets/custom_rich_text_widget.dart';
import 'package:rbc_control/presentation/widgets/custom_text_field.dart';
import 'package:rbc_control/routes/app_route_name.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPassC = TextEditingController();
  bool checkBox = false;
  bool isButtonDisabled = false;
  void check() {
    checkBox = !checkBox;
    setState(() {});
  }

  @override
  void dispose() {
    nameC.dispose();
    emailC.dispose();
    passwordC.dispose();
    confirmPassC.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (nameC.text.isEmpty) {
      Utils.fireSnackBar(
        context,
        message: "Name is not filled",
        backgroundColor: Colors.red,
      );
    } else if (nameC.text.isEmpty) {
      Utils.fireSnackBar(
        context,
        message: "Surname is not filled",
        backgroundColor: Colors.red,
      );
    } else if (passwordC.text.length < 6) {
      Utils.fireSnackBar(
        context,
        message: "Password should be more than 6 char",
        backgroundColor: Colors.red,
      );
    } else if (passwordC.text != confirmPassC.text) {
      Utils.fireSnackBar(
        context,
        message: "Confirm password is not same with password",
        backgroundColor: Colors.red,
      );
    } else {
      User? user = await AuthMethods.signUp(
        context,
        fullName: nameC.text,
        email: emailC.text,
        password: passwordC.text,
      );
      log(user.toString());
      if (user != null) {
        context.go(AppRouteName.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppbarWidget(
        title: "Register",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const CustomAuthTitle(
                title: "Getting Started",
                subTitle: "Seems you are new here, Let's set up your profile.",
              ),
              CustomTextField(
                hintText: "Full Name",
                controller: nameC,
                keyBoardType: TextInputType.name,
                labelText: "Full Name",
                textInputAction: TextInputAction.next,
              ),
              CustomTextField(
                hintText: "Email address",
                controller: emailC,
                keyBoardType: TextInputType.emailAddress,
                labelText: "Email address",
                textInputAction: TextInputAction.next,
              ),
              CustomTextField(
                hintText: "Password",
                controller: passwordC,
                keyBoardType: TextInputType.visiblePassword,
                labelText: "Password",
                textInputAction: TextInputAction.next,
              ),
              CustomTextField(
                hintText: "Confirm Password",
                controller: confirmPassC,
                keyBoardType: TextInputType.visiblePassword,
                labelText: "Confirm Password",
                textInputAction: TextInputAction.go,
              ),
              CustomRegisterCheckbox(
                checkbox: checkBox,
                text: 'By creating an account, you agree to our',
                navigateText: '\nTerm and Conditions',
                onPressedButton: check,
              ),
              CustomButton(
                text: "Continue",
                onPressed: () async {
                  if (checkBox && !isButtonDisabled) {
                    isButtonDisabled = true;
                    await register();
                    isButtonDisabled = false;
                  }
                },
                backgroundColor: checkBox == false ? AppColors.cD9D9D9 : null,
                textColor: checkBox == false ? AppColors.black : null,
              ),
              const CustomRichText(
                text: "Already have an account ? ",
                navigateText: "Login",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

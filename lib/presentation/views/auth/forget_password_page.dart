import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/utils.dart';
import '../../../routes/app_route_name.dart';
import '../../widgets/custom_auth_title.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  ForgetPasswordPageState createState() => ForgetPasswordPageState();
}

class ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    emailController.removeListener(_validateEmail);
    emailController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    final email = emailController.text;
    setState(() {
      isFormValid = email.isNotEmpty && email.contains('@');
    });
  }

  Future<void> _resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );
      Utils.fireSnackBar(
        context,
        message: 'Password reset email sent',
        backgroundColor: Colors.green,
      );
      context.go(
          '${AppRouteName.login}/${AppRouteName.forgetPassword}/${AppRouteName.forgetPasswordResetEmail}');
    } catch (e) {
      Utils.fireSnackBar(
        context,
        message: 'Error: ${e.toString()}',
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const CustomAuthTitle(
                title: "Forget Password",
                subTitle: "Enter your email address to reset password",
              ),
              CustomTextField(
                controller: emailController,
                keyBoardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                hintText: "example@gmail.com",
                labelText: "Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is not filled";
                  } else if (!value.contains('@')) {
                    return "Invalid email address";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Send Password Reset Email",
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _resetPassword();
                  }
                },
                backgroundColor: isFormValid ? null : AppColors.cD9D9D9,
                textColor: isFormValid ? null : AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

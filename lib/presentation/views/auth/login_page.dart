// lib/presentation/views/login_screen.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/utils.dart';
import '../../../gen/assets.gen.dart';
import '../../../routes/app_route_name.dart';
import '../../widgets/custom_auth_title.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/sign_in_chekbox.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool vision = false;
  bool checkBox = false;

  void togglePasswordVisibility() {
    setState(() {
      vision = !vision;
    });
  }

  void check() {
    checkBox = !checkBox;
    setState(() {});
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailC.text,
        password: passC.text,
      );

      User? user = userCredential.user;
      if (user != null) {
        context.go(AppRouteName.home);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils.fireSnackBar(
          context,
          message: "No User Found for that Email",
          backgroundColor: Colors.red,
        );
      } else if (e.code == 'wrong-password') {
        Utils.fireSnackBar(
          context,
          message: "Wrong Password Provided by User",
          backgroundColor: Colors.red,
        );
        
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;
      if (user != null) {
        context.go(AppRouteName.home);
      }
    } on FirebaseAuthException catch (e) {
      Utils.fireSnackBar(
        context,
        message: e.message ?? "An error occurred",
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const CustomAuthTitle(
                  title: "'Let’s Sign You In",
                  subTitle: "Welcome back, you’ve been missed!",
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  controller: emailC,
                  keyBoardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
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
                const SizedBox(height: 24),
                CustomTextField(
                  controller: passC,
                  keyBoardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: vision,
                  hintText: "Enter your password",
                  labelText: "Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is not filled";
                    } else if (value.length < 6) {
                      return "Password should be more than 6 characters";
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: togglePasswordVisibility,
                    icon: vision
                        ? const Icon(Icons.visibility, color: Color(0xFFADADAD))
                        : const Icon(Icons.visibility_off,
                            color: Color(0xFFADADAD)),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Logincheckbox(
                      checkbox: checkBox,
                      text: 'Remember me',
                      onPressedButton: check,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Forgot Password ?',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 1.7,
                          letterSpacing: -0.3,
                          color: const Color(0xFFFD6B22),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go(
                                '${AppRouteName.login}/${AppRouteName.forgetPassword}');
                          },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: "Sign In",
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _signInWithEmailAndPassword();
                    }
                  },
                  backgroundColor: checkBox == false ? AppColors.cD9D9D9 : null,
                  textColor: checkBox == false ? AppColors.black : null,
                ),
                const SizedBox(height: 16),
                Text(
                  'OR',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    height: 1.7,
                    letterSpacing: 1,
                    color: const Color(0xFF8F92A1),
                  ),
                ),
                const SizedBox(height: 16),
                MaterialButton(
                  onPressed: _signInWithGoogle,
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.white,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.images.google
                          .svg(height: 16, width: 16, fit: BoxFit.cover),
                      const SizedBox(width: 10),
                      Text(
                        'Continue with Google',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          height: 1.4,
                          letterSpacing: -0.4,
                          color: const Color(0xFF171717),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      letterSpacing: -0.2,
                      color: const Color(0x80000000),
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          letterSpacing: -0.2,
                          color: const Color(0xFFFD6B22),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go(
                                '${AppRouteName.login}/${AppRouteName.register}'); 
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

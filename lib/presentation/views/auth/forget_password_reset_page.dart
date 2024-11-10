import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../routes/app_route_name.dart';
import '../../widgets/custom_auth_title.dart';
import '../../widgets/custom_rich_text_widget.dart';

class ForgetPasswordResetPage extends StatefulWidget {
  const ForgetPasswordResetPage({
    super.key,
  });

  @override
  ForgetPasswordResetPageState createState() => ForgetPasswordResetPageState();
}

class ForgetPasswordResetPageState extends State<ForgetPasswordResetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomAuthTitle(
              title: "Reset email sent",
              subTitle:
                  "We have sent all required instructions details to your mail.",
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black38,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(color: Colors.black), // Border color
                ),
              ),
              onPressed: () {
                context.replace(AppRouteName.login);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomRichText(
                    textFontWeight: FontWeight.w900,
                    text: "Go to Login page",
                    textSize: 16.0,
                    textColor: Colors.black,
                  ),
                  SizedBox(
                    height: 56,
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 20.0,
                    weight: 10.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

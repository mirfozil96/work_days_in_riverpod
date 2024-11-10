import 'package:d_navigation_bar/d_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_route_name.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class PrimaryPage extends StatelessWidget {
  final Widget child;
  const PrimaryPage(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: child, // Faqatgina asosiy sahifani ko'rsatadi
      bottomNavigationBar: BottomNavigationBarBackground(
        child: DNavigationBar(
          onChanged: (index) {
            context.go(
              index == 0
                  ? AppRouteName.home
                  : index == 1
                      ? AppRouteName.home
                      : index == 2
                          ? AppRouteName.home
                          : AppRouteName.profile,
            );
          },
          backgroundColor: Colors.transparent,
          useShadow: false,
          items: [
            DNavigationBarItem(
              icon: const Icon(Icons.home),
              activeIcon: const Icon(Icons.home_outlined),
            ),
            DNavigationBarItem(
              icon: const Icon(Icons.notifications),
              activeIcon: const Icon(Icons.notifications_outlined),
            ),
            DNavigationBarItem(
              icon: const Icon(Icons.settings),
              activeIcon: const Icon(Icons.settings_outlined),
            ),
            DNavigationBarItem(
              icon: const Icon(Icons.person),
              activeIcon: const Icon(Icons.person_2_outlined),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import '../../../routes/app_route_name.dart';
import 'package:go_router/go_router.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    context.go(AppRouteName.splashPage);
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Center(
        child: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  user.photoURL != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(user.photoURL!),
                        )
                      : const CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.person),
                        ),
                  const SizedBox(height: 16),
                  Text(
                    user.displayName ?? "No Name",
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email ?? "No Email",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              )
            : const Text('No user information available'),
      ),
    );
  }
}

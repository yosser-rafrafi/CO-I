import 'package:co_i_front2/pages/auth_page.dart';
import 'package:co_i_front2/pages/malvoyants_list.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  const MalvoyantsList();
          } else {
            return  const AuthPage();
          }
        },
      ),
    );
  }
}

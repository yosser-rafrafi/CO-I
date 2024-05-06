
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage ;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//text controllers
final _emailController = TextEditingController();
final _passwordController = TextEditingController();

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        
      );
    } catch (e) {
      // Handle sign in errors here
      // ignore: avoid_print
      print('Sign in failed: $e ');
    }
  }
  @override
  void dispose()
  {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25.0 ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/clipfly-ai-20240417202439.png'), // Chemin de votre image de fond
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Hello Again!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5), // Couleur de fond transparente
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child:  Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Email',
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5), // Couleur de fond transparente
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child:  Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Password',
  ),
),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => signIn(),

            child: Container(
              decoration: BoxDecoration(
                // ignore: prefer_const_constructors
                color: Color.fromARGB(255, 57, 158, 240), // Couleur de fond transparente
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Not a member?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: widget.showRegisterPage,
                child: const Text(
                  ' Register Now',
                  style: TextStyle(
                    color: Color.fromARGB(255, 57, 158, 240),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
                ],
              ),
            ),
          ),
                  
                ],
                
              ),
            ),
          ),
        ),
      );
  }
}






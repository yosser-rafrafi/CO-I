
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
                  


              //Email text Field
              const SizedBox(height: 10),        
              Container(
                decoration: 
                BoxDecoration
                (
                  color: const Color.fromARGB(255, 255, 253, 253).withOpacity(0.5),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding
                    (
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: 
                      TextField(
                        controller: _emailController,
                        decoration: 
                        InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mail Adress',
                          prefix: 
                          SizedBox(
                            width: 30, // Augmentez ou diminuez cette valeur selon vos besoins
                            child: Image.asset('lib/images/mail.png', width: 20, height: 20),
                          ),
                        ),
                      ),
                    ),

                    // Line 
                    Container(
                      height: 1, // hauteur de la ligne
                      color: Colors.grey, // couleur de la ligne
                      ),
                  ],
                ),
              ),





              //password text Field
              const SizedBox(height: 10),
              Container(
                decoration: 
                BoxDecoration(
                  color: const Color.fromARGB(255, 255, 253, 253).withOpacity(0.5),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child:
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: 
                        InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          prefix: 
                          SizedBox(
                            width: 30, // Augmentez ou diminuez cette valeur selon vos besoins
                            child: Image.asset('lib/images/padlock.png', width: 20, height: 20),
                            ),
                        ),
                     ),
                    ),
                    Container(
                      height: 1, // hauteur de la ligne
                      color: Colors.grey, // couleur de la ligne
                    ),
                  ],
                ),
              ),


          // boutton signIn
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => signIn(),

            child: Container(
             // height: 45,
              decoration: BoxDecoration(
                // ignore: prefer_const_constructors
                color: Color.fromARGB(255, 112, 206, 227), // Couleur de fond transparente
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
                    color: Color.fromARGB(255, 18, 159, 169),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
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






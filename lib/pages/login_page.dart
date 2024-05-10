
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
        child: Stack(
          children: [
            // Image de fond
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/clipfly-ai-20240417202439.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // SingleChildScrollView avec le contenu interne
            
              
                
                   Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: Column(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                'Hello Again!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
                                ),
                              ),
                              //Welcome back text
                          Text(
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          ],
                        ),
                        
                        
                     
                     
                                       
                     
                        Container(
                          
                          decoration:
                            BoxDecoration(
                              color: const Color.fromARGB(255, 255, 253, 253).withOpacity(0.7),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Column(
                              children: [
                                // Firstname text Field
                                const SizedBox(height: 10),        
                                
                     
                     
                                
                     
                                // email  text Field
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 253, 253).withOpacity(0.01),                              
                              ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Row(
                                            children: [
                                              SizedBox(
                                                width: 30, // Augmentez ou diminuez cette valeur selon vos besoins
                                                child: Image.asset('lib/images/mail.png', width: 20, height: 20),
                                              ),
                                              const SizedBox(width: 10),                                     
                                              Expanded(
                                                child: TextField(
                                                  controller: _emailController,
                                                  decoration:
                                                  const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Mail Adress',
                                                  ),
                                                ),
                                              )
                                            ]
                                          ),
                                      ),
                                      Container(
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                     
                                // password text Field
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 253, 253).withOpacity(0.01),                              
                              ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child:Row(
                                            children: [
                                              SizedBox(
                                                  width: 30, // Augmentez ou diminuez cette valeur selon vos besoins
                                                  child: Image.asset('lib/images/padlock.png', width: 20, height: 20),
                                              ),
                                              
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: TextField(
                                                controller: _passwordController,
                                                obscureText: true,
                                                decoration: 
                                                const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Password', 
                                                  
                                                ),
                                                                                    ),
                                              ),
                                            ]
                                          ),
                                      ),
                                      Container(
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                     
                               
                     
                                // Bouton signIn
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: ()  => signIn(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 112, 206, 227),
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
                                const SizedBox(height: 15),
                                // Not a member text
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'I am member!',
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
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                           
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






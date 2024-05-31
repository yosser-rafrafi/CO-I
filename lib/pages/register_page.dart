import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
  
 Future signUp() async {
  // Vérifier si tous les champs sont remplis
  if (_firstNameController.text.isEmpty ||
      _lastNameController.text.isEmpty ||
      _phoneNumberController.text.isEmpty ||
      _emailController.text.isEmpty ||
      _passwordController.text.isEmpty ||
      _confirmpasswordController.text.isEmpty) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Please fill in all fields.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    return;
  }

  // Vérifier le format de l'adresse email
  if (!isValidEmail(_emailController.text.trim())) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Please enter a valid email address.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    return;
  }

  // Vérifier si l'adresse email existe déjà
  final emailExists = await checkIfEmailExists(_emailController.text.trim());
  if (emailExists) {
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('This email address is already registered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    return;
  }

  // Vérifier le format du numéro de téléphone
  if (!isValidPhoneNumber(_phoneNumberController.text.trim())) {
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Please enter a valid phone number.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    return;
  }

  // Vérifier si le mot de passe est confirmé
  if (!passwordConfirmed()) {
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Passwords do not match.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    return;
  }

  
createUser();

}

// Si toutes les vérifications passent, créer l'utilisateur
   Future<void> createUser() async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword
    (
      email: _emailController.text.trim(),
      password: _passwordController.text.trim()
    );
    addUserDetails(
      
      _firstNameController.text.trim(),
      _lastNameController.text.trim(),
      _emailController.text.trim(),
      int.parse(_phoneNumberController.text.trim())
      );
    AlertDialog(
          content: const Text('inscription reussi'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
    // Utilisateur créé avec succès
  } catch (e) {
    // Gérer les erreurs ici
    // ignore: avoid_print
    print('Error: $e');
    // Afficher un message d'erreur à l'utilisateur
    // ignore: use_build_context_synchronously
     showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text('$e'),
        actions: [
          TextButton(
            onPressed: () {
             
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
  }
}

Future<bool> checkIfEmailExists(String email) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get();
  return querySnapshot.docs.isNotEmpty;
}

bool isValidEmail(String email) {
  // Expression régulière pour valider le format de l'adresse email
  final RegExp emailRegex =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

bool isValidPhoneNumber(String phoneNumber) {
  // Expression régulière pour valider le format du numéro de téléphone (10 chiffres)
  final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');
  return phoneRegex.hasMatch(phoneNumber);
}

bool passwordConfirmed() {
    if (_passwordController.text.trim() == _confirmpasswordController.text.trim()){
      return true;
    } else {
      return false;
    }
  }




  Future addUserDetails( String firstName, String lastName, String email , int phoneNumber) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name' :lastName ,
      'phone number':phoneNumber ,
      'email':email ,}
    );
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
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0 ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 55),
                      const Text(
                        'HELLO THERE',
                        style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                        
                      ),
                      const SizedBox(height: 10),
                     const Text(
                          'Register below with your details!',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      


                      const SizedBox(height: 40),

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
                              Container(
                                decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 253, 253).withOpacity(0.01),                              
                            ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: TextField(
                                        controller: _firstNameController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'First Name',
                                        ),
                                      ),
                                    ),
                                    // Line 
                                    Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),

                              // last name  text Field
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
                                      child: TextField(
                                        controller: _lastNameController,
                                       
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Last Name',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),

                              // phone number  text Field
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
                                      child: TextField(
                                        controller: _phoneNumberController,
                                        
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Phone Number',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),

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
                                      child: TextField(
                                        controller: _emailController,
                                        
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Email',
                                        ),
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
                                      child: TextField(
                                        controller: _passwordController,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),

                              // lconfirm passsworf  text Field
                              const SizedBox(height: 10),
                              Container(
                                decoration:BoxDecoration(
                              color: const Color.fromARGB(255, 255, 253, 253).withOpacity(0.01),                              
                            ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: TextField(
                                        controller: _confirmpasswordController,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Confirm Password',
                                        ),
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
                                onTap: () => signUp(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 112, 206, 227),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Center(
                                      child: Text(
                                        'Sign Up',
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
                                    onTap: widget.showLoginPage,
                                    child: const Text(
                                      ' Login Now',
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
                      const SizedBox(height: 30),
                    ],
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
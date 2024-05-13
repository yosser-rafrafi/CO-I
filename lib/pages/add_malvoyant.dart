import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_i_front2/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AddMalvoyantPage extends StatefulWidget {
   const AddMalvoyantPage({super.key}) ;


  @override
  State<AddMalvoyantPage> createState() => _AddMalvoyantPageState();
     
}

class _AddMalvoyantPageState extends State<AddMalvoyantPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  
  final FirestoreService firestoreService = FirestoreService();
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final user = FirebaseAuth.instance.currentUser!.email;
     final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
  backgroundColor: const Color.fromRGBO(243, 243, 243, 1.0),
  body: SingleChildScrollView(
    
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
         Container(
                  width: MediaQuery.of(context).size.width,
                  height: 170, // Hauteur de l'en-tête
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(21, 137, 179, 1), // Couleur foncée en haut
                       Color.fromRGBO(136, 222, 254, 1), // Couleur claire en bas
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight:Radius.circular(30),
                      bottomLeft:Radius.circular(30),
                    ),
                   ),

                  
                    
                        child: Stack(
                          children:[ 
                            Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 28.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Welcome',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              
                                
                              Padding(
                                padding: const EdgeInsets.only(left: 2.5),
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: _firestore.collection('users').where('email', isEqualTo: user).snapshots(),
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Erreur: ${snapshot.error}');
                                    }
                              
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Text('Chargement...');
                                    }
                              
                                    if (snapshot.data!.docs.isEmpty) {
                                      return const Text('Aucun utilisateur trouvé.');
                                    }
                              
                                    // Si l'utilisateur est trouvé, accédez à ses données
                                    String firstName = snapshot.data!.docs[0]['first name'];
                                    String lastName = snapshot.data!.docs[0]['last name'];
                              
                                    return Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                         '$firstName $lastName',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                               
                            ],
                            
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 27.0),
                            child: Align(
                                
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {
                                  },
                                  color: Colors.white,
                                  iconSize: 34,
                                  icon: const Icon(Icons.account_circle), // Utilisation de l'icône de compte utilisateur
                                ),
                              ),
                          ),
                          ],
                        ),
                        
                          
                        
                     
                    
                  
                ),
        
        

        // formulaire 
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 5),
              const Text(
                ' Add Malyovant',
                style: TextStyle(
                 fontSize: 18,
                 fontWeight: FontWeight.w500,
                 color: Color.fromRGBO(54, 48, 48, 0.898),
                ),
                ),
                const SizedBox(height: 10),
              
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(106, 198, 232, 1),),),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Récupérer les valeurs des champs texte
                  String firstName = _firstNameController.text;
                  String lastName = _lastNameController.text;
                  String phoneNumber = _phoneNumberController.text;
              
                  // Ajouter un nouveau malvoyant avec les données fournies
                  firestoreService.addMalvoyant(
                    firstName,
                    lastName,
                    phoneNumber,
                    userId,
                  );
              
                  // Effacer les champs texte après l'ajout
                  _firstNameController.clear();
                  _lastNameController.clear();
                  _phoneNumberController.clear();
              
                  // Naviguer vers l'écran précédent
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(106, 198, 232, 1), // Couleur de fond
                  side: const BorderSide(color: Colors.white), // Bordure autour du bouton
                  
                ),
                child: const Text(
                  'Add Malvoyant',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
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

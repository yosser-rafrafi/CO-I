import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_i_front2/pages/edit_person.dart';
import 'package:co_i_front2/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonDetailsPage extends StatelessWidget {
  final String docID;
  final String firstName;
  final String lastName;
  final String relationship;
  final String imageUrl;


final FirestoreService firestoreService = FirestoreService();
   PersonDetailsPage({
    super.key, 
    required this.docID,
    required this.firstName,
    required this.lastName,
    required this.relationship,
    required this.imageUrl});
    final user = FirebaseAuth.instance.currentUser!.email;
     final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // Fetch person details using docID from Firestore or any other method
    // For demonstration purposes, I'm just displaying the docID here
return Scaffold(
  backgroundColor: const Color.fromRGBO(243, 243, 243, 1.0),
  body: SingleChildScrollView(
    
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.start, 
        children: <Widget>[ 
          
             
          // En-tête personnalisé et image de profil
           
             Stack(
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
                                  icon: Icon(Icons.account_circle), // Utilisation de l'icône de compte utilisateur
                                ),
                              ),
                          ),
                          ],
                        ),                  
                ),
                // Image de profil
                Padding(
                  padding: const EdgeInsets.only(top: 90, bottom: 20),
                  child: SizedBox(
                    height: 220,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3.8, // Définir l'épaisseur de la bordure
                        ),
                      ),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.3,
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                    ),
                  ),
                ),
              ],
            ),
           
          
            
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(
                  
                    
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                        ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'First Name :',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color : Color.fromRGBO(46, 160, 201, 1),
                                    ),
                                  ),
                                  Text(
                                    'Last Name :',
                                     style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color : Color.fromRGBO(46, 160, 201, 1),
                                    ),
                                  ),
                                  Text(
                                    'Relationship :',
                                     style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color : Color.fromRGBO(46, 160, 201, 1),
                                    ),
                                  ),
                                  
                                
                                ],
                              ),
                             Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                  firstName,
                                  style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(54, 48, 48, 0.898),
                                  ),
                                 ),
                                  Text(
                                lastName ,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(54, 48, 48, 0.898),

                                  ),
                                 ),
                                 Text(
                                relationship,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(54, 48, 48, 0.898),
                                ),
                              ),
                                  
                               ],
                             ),
                            ],
                
                          ),
                          const SizedBox(height: 10,),  
                          
                        ],
                      ),
                    ),
                  
                  
                  
                
                            
                          ),
              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditPersonPage(
                                        docID: docID,
                                        firstName: firstName,
                                        lastName: lastName,
                                        imageUrl: imageUrl,
                                        relationship: relationship,
                                      ),
                                    ),
                                  );
                                },
                                icon: Image.asset(
                                  'lib/images/pen.png', // Remplacer 'your_image.png' par le nom de votre image
                                  height: 40, // Ajouter la hauteur souhaitée
                                  width: 40, // Ajouter la largeur souhaitée
                                ),
                              ),


                              IconButton(
                                onPressed: () {
                                  // Supprimer la personne
                                  firestoreService.deletePerson(docID);
                                  // Retourner à la HomePage
                                  Navigator.pop(context);
                                },
                                icon: Image.asset(
                                  'lib/images/delete.png', // Remplacer 'your_image.png' par le nom de votre image
                                  height: 40, // Ajouter la hauteur souhaitée
                                  width: 40, // Ajouter la largeur souhaitée
                                ),
                              ),
                              IconButton(
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut();
                                      },
                                      icon: const Icon(Icons.login),
                                    ),

                            ],
                          )
        ] ,
      ),
    
  ),
);



}
}
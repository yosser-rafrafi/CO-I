
import 'package:co_i_front2/pages/blue_header.dart';
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
             Stack(
              children:  <Widget>[
              // Header
              BlueHeader(),
            
              // Image de profil
              Padding(
                  padding: const EdgeInsets.only(top: 150, bottom: 20),
                  child: SizedBox(
                    height: 250,
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
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  
                    
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 40),
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
                                  SizedBox(height: 5),
                                  Text(
                                    'Last Name :',
                                     style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color : Color.fromRGBO(46, 160, 201, 1),
                                    ),
                                  ),
                                  SizedBox(height: 5),
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
                                const SizedBox(height: 5),
                                  Text(
                                lastName ,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(54, 48, 48, 0.898),

                                  ),
                                 ),
                                const SizedBox(height: 5),
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
                          const SizedBox(height: 10),  
                          
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
                                  'lib/images/ediit.png', // Remplacer 'your_image.png' par le nom de votre image
                                  height: 60, // Ajouter la hauteur souhaitée
                                  width: 60, // Ajouter la largeur souhaitée
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
                                  height: 60, // Ajouter la hauteur souhaitée
                                  width: 60, // Ajouter la largeur souhaitée
                                ),
                              ),
                              

                            ],
                          )
        ] ,
      ),
    
  ),
);



}
}
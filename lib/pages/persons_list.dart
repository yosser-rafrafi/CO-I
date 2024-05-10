// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_i_front2/pages/add_person.dart';
import 'package:co_i_front2/pages/card.dart';
import 'package:co_i_front2/pages/malvoyants_list.dart';
import 'package:co_i_front2/pages/person_details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class PersonsListPage extends StatefulWidget {
  final String MalvoyantId;

  const PersonsListPage({super.key, required this.MalvoyantId});

  @override
  State<PersonsListPage> createState() => _PersonsListPageState();
}

class _PersonsListPageState extends State<PersonsListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personnes"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.login),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MalvoyantsList()),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('persons').where('malvoyantId', isEqualTo: widget.MalvoyantId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List personsList = snapshot.data!.docs;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 36.0,
              ),
              itemCount: personsList.length + 1, // Increment the item count by 1
              itemBuilder: (context, index) {
                if (index == personsList.length) { // Check if it's the last item
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddPersonPage(
                            malvoyantId: widget.MalvoyantId,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          size: 48.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                } else {
                  DocumentSnapshot document = personsList[index];
                  String docID = document.id;
                  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                  String firstname = data['firstname'];
                  String lastname = data['lastname'];
                  String image = data['image'];
                  String relationship = data['relationship'];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonDetailsPage(
                            docID: docID,
                            firstName: firstname,
                            lastName: lastname,
                            imageUrl: image,
                            relationship: relationship,
                          ),
                        ),
                      );
                    },
                    child: CustomCard(
                      title: '$firstname $lastname',
                      subtitle: relationship,
                      imageUrl: image,
                    ),
                  );
      
                }
              },
            );
          } else if (snapshot.hasError) {
            return const Text("No persons..!");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
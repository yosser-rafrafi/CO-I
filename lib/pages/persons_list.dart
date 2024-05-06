import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_i_front2/pages/add_person.dart';
import 'package:co_i_front2/pages/login_page.dart';
import 'package:co_i_front2/pages/person_details_page.dart';
import 'package:co_i_front2/services/firestore.dart';
import 'package:flutter/material.dart';

class PersonsList extends StatefulWidget {
  const PersonsList({super.key});

  @override
  State<PersonsList> createState() => _PersonsListState();
}

class _PersonsListState extends State<PersonsList> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personnes"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            icon: const Icon(Icons.login),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPersonPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getPersonsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List personsList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: personsList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = personsList[index];
                String docID = document.id;
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
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
                  child: ListTile(
                    title: Text('$firstname $lastname'),
                    subtitle: Text(relationship),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(image),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Text("No persons..!");
          }
        },
      ),
    );
  }
}

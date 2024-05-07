import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_i_front2/pages/add_malvoyant.dart';
import 'package:co_i_front2/pages/malvoyant_details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MalvoyantsList extends StatefulWidget {
  const MalvoyantsList({super.key}) ;

  @override
  State<MalvoyantsList> createState() => _MalvoyantsListState();
}

class _MalvoyantsListState extends State<MalvoyantsList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("malvoyants List"),
      actions: [
        IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.login),
          ),
          

      ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMalvoyantPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:_firestore.collection('malvoyants').where('userId', isEqualTo: userId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> malvoyantsList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: malvoyantsList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = malvoyantsList[index];
                String docID = document.id;

                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String firstname = data['first name'];
                String lastname = data['last name'];
                String phoneNumber = data['phone number'];

                return ListTile(
                  title: Text('$firstname $lastname'),
                  subtitle: Text(phoneNumber),
                  // Actions à effectuer lors du tap sur un malvoyant
                  onTap: () {
                    
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => MalvoyantDetailsPage(docID: docID,
                    firstName: firstname,
                    lastName: lastname, 
                    phoneNumber: phoneNumber,
                    
                    ),
                    ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Une erreur s'est produite : ${snapshot.error}");
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

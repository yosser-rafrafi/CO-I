

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_i_front2/services/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

//firestore
final FirestoreService firestoreService = FirestoreService();
  // text controller 
  final TextEditingController textController = TextEditingController();
//open a dialog vox to add a person 
void openPersonBox()
{
  showDialog(context: context, 
  builder: (context) =>  AlertDialog(
    content: TextField(
      controller: textController,
    ),
    actions: [
      // button to save 
      ElevatedButton(
        onPressed: () {
          //add a new person
          firestoreService.addPerson(textController.text);

          //clear the text controller
          textController.clear();
          
          //close the box 
          Navigator.pop(context);
        },
         child: Text("Add"),
         )
    ],
    ),
    );
}

  @override
  Widget build(BuildContext context){
    return Scaffold( 
      appBar: AppBar(title: const Text("Persons")),
      floatingActionButton: FloatingActionButton(
        onPressed: openPersonBox,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getPersonsStream(),
        builder: (context, snapshot) {
          //if we have data ,get all the docs 
          if (snapshot.hasData)
          {
            List personsList = snapshot.data!.docs;
            //display as a List 
            return ListView.builder(
              itemCount: personsList.length,
              itemBuilder: (context , index)
            {
              // get each individual doc
              DocumentSnapshot document = personsList[index];
              String docId = document.id;
              
              // get person from each doc
              Map<String, dynamic> data = 
              document.data() as Map<String, dynamic>;
              String personText = data['person'];
               
              // display as a List 
              return ListTile(
                title : Text(personText),
              );


            },
            );

          }
          // if there is no data return
          else{
            return const Text("No Persons..");

          }
        },

      ),
    );
  }
}
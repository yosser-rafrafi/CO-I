

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService
{
  //get collection of person
  
  final CollectionReference persons =
  FirebaseFirestore.instance.collection('persons');

  //CREATE : add a new person
  Future <void> addPerson (String person){
    return persons.add({
      'person' : person,
      'timestamp': Timestamp.now(),
    });
    }

    //READ : get persons from database 
    Stream<QuerySnapshot> getPersonsStream(){
      final PersonsStream =
      persons.orderBy('timestamp',descending: true).snapshots();

      return PersonsStream;
    }

    //UPDATE : update persons given a doc id
    Future<void> updatePerson (String docID, String newPerson)
    {
      return persons.doc(docID).update({
        'person': newPerson ,
        'timestamp' : Timestamp.now(),
    
      });
    }
    
    // DELETE : delete persons give, a doc id 
       Future<void> deletePerson (String docID)
       {
        return persons.doc(docID).delete();
       }
}
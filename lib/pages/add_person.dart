import 'package:co_i_front2/services/firestore.dart';
import 'package:flutter/material.dart';

class AddPersonPage extends StatefulWidget {
  final String malvoyantId ;
 const AddPersonPage({super.key, required this.malvoyantId}) ;

  @override
  State<AddPersonPage> createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();

  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Person',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
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
              controller: _imageUrlController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _relationshipController,
              decoration: const InputDecoration(
                labelText: 'Relationship',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Récupérer les valeurs des champs texte
                String firstName = _firstNameController.text;
                String lastName = _lastNameController.text;
                String imageUrl = _imageUrlController.text;
                String relationship = _relationshipController.text;

                // Ajouter une nouvelle personne avec les données fournies
                firestoreService.addPerson(
                  firstName,
                  lastName,
                  imageUrl,
                  relationship,
                  widget.malvoyantId
                  
                  
                );

                // Effacer les champs texte après l'ajout
                _firstNameController.clear();
                _lastNameController.clear();
                _imageUrlController.clear();
                _relationshipController.clear();

                // Naviguer vers l'écran précédent
                Navigator.pop(context);
              },
              child: const Text('Add Person'),
            ),
            
          ],
        ),
      ),
    );
  }
}

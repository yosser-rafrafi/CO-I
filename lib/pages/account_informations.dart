
import 'package:flutter/material.dart';

class AccountInformationsPage extends StatelessWidget {
  const AccountInformationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Informations'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           

            Text(
              'Account Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('Name'),
              subtitle: Text('John Doe'), // Remplacez par le nom de l'utilisateur
            ),
            ListTile(
              title: Text('Email'),
              subtitle: Text('john.doe@example.com'), // Remplacez par l'e-mail de l'utilisateur
            ),
            ListTile(
              title: Text('Phone Number'),
              subtitle: Text('+1234567890'), // Remplacez par le numéro de téléphone de l'utilisateur
            ),

                                                      
            // Ajoutez d'autres informations du compte ici
          ],
        ),
      ),
    );
  }
}

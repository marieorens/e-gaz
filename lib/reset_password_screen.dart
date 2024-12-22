import 'package:flutter/material.dart';
import 'package:egaz/auth_service.dart'; 

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

 
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50], 
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 211, 232, 213), 
        title: const Text("Réinitialisation du mot de passe"),
        centerTitle: true, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Entrez votre adresse email pour réinitialiser votre mot de passe:",
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 1, 9, 1), 
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),
            
            // Champ Email avec un design moderne
            TextField(
              controller: _emailController, 
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: const TextStyle(color: Color.fromARGB(255, 3, 17, 3)), 
                hintText: 'example@gmail.com',
                hintStyle: TextStyle(color: Colors.green[300]), // Texte de l'info-bulle
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Bordures arrondies
                  borderSide: BorderSide(color: Colors.green[400]!, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.green[600]!, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Bouton d'envoi
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Appeler la fonction de récupération de mot de passe
                  String? result = await AuthService().resetPassword(_emailController.text.trim());
                  
                  if (result == null) {
                    // Afficher un message de succès
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Un email a été envoyé pour réinitialiser votre mot de passe.")),
                    );
                  } else {
                    // Afficher un message d'erreur
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result)),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), 
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Envoyer",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

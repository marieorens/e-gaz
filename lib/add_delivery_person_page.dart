import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddDeliveryPersonPage extends StatefulWidget {
  const AddDeliveryPersonPage({super.key});

  @override
  _AddDeliveryPersonPageState createState() => _AddDeliveryPersonPageState();
}

class _AddDeliveryPersonPageState extends State<AddDeliveryPersonPage> {
  final _formKey = GlobalKey<FormState>();
  final bool isDarkMode = false; // Remplacez avec votre gestion de thème

  // Contrôleurs pour les champs du formulaire
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _engineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajouter un livreur',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.black : const Color(0xFFEAEAEA),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: Center(  // Centrage du formulaire dans le corps de la page
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,  // Ajoutez la clé de formulaire pour la validation
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centre verticalement
                crossAxisAlignment: CrossAxisAlignment.center,  // Centre horizontalement
                mainAxisSize: MainAxisSize.min,  // Adapte la taille de la colonne au contenu
                children: [
                  _buildTextField(label: 'Nom', controller: _nameController, isDarkMode: isDarkMode),
                  const SizedBox(height: 16),
                  _buildTextField(label: 'Prénom', controller: _surnameController, isDarkMode: isDarkMode),
                  const SizedBox(height: 16),
                  _buildTextField(label: 'Contact', controller: _contactController, isDarkMode: isDarkMode),
                  const SizedBox(height: 16),
                  _buildTextField(label: 'Engin', controller: _engineController, isDarkMode: isDarkMode),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      // Vérification de la validation du formulaire
                      if (_formKey.currentState?.validate() ?? false) {
                        // Si le formulaire est valide, on enregistre le livreur
                        // Logique pour enregistrer le livreur
                        print("Livreur enregistré");
                      } else {
                        // Si le formulaire n'est pas valide, on affiche un message d'erreur
                        print("Le formulaire n'est pas valide");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    ),
                    child: Text(
                      'Enregistrer',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller, required bool isDarkMode}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ce champ ne peut pas être vide';
        }
        return null; // Retourne null si la validation est réussie
      },
    );
  }
}

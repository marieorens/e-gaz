import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_delivery_person_page.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Nombre de colonnes
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          children: [
            _buildOption(
              context,
              icon: Icons.storage,
              label: 'Mon stock',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StockPage()),
                );
              },
            ),
            _buildOption(
              context,
              icon: Icons.star,
              label: 'Voir mes notes',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReviewsPage()),
                );
              },
            ),
            _buildOption(
              context,
              icon: Icons.location_on,
              label: 'Changer mon emplacement',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LocationPage()),
                );
              },
            ),
            _buildOption(
              context,
              icon: Icons.local_shipping,
              label: 'Gérer les livreurs',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DeliveryPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEAEAEA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Exemples de pages pour les différentes sections

class StockPage extends StatelessWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context) {
    const bool isDarkMode =
        false; // Remplacez cette logique par votre gestion de thème

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mon Stock',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.black : const Color(0xFFEAEAEA),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Marge autour de tout le contenu
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Affichage des types de gaz
            Text(
              'Types de Gaz',
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _GasCard(gasName: 'Oryx'),
                _GasCard(gasName: 'Bénin Petro'),
                _GasCard(gasName: 'ProGaz'),
              ],
            ),
            const SizedBox(height: 32),

            // Affichage des quantités de bouteilles

            const SizedBox(height: 16),
            const Column(
              children: [
                // Emballage de chaque carte avec Padding et Expanded
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 16), // Marge entre les cartes
                  child: Expanded(
                    child: _QuantityCard(
                        label: 'Petites Bouteilles', quantity: 426),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 16), // Marge entre les cartes
                  child: Expanded(
                    child: _QuantityCard(
                        label: 'Grandes Bouteilles', quantity: 332),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // Bouton flottant pour ajouter du gaz
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddGasFormPage()),
          );
        },
        backgroundColor: isDarkMode ? Colors.yellow : Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _GasCard extends StatelessWidget {
  final String gasName;

  const _GasCard({required this.gasName});

  @override
  Widget build(BuildContext context) {
    const bool isDarkMode =
        false; // Remplacez cette logique par votre gestion de thème

    return Card(
      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          gasName,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class _QuantityCard extends StatelessWidget {
  final String label;
  final int quantity;

  const _QuantityCard({required this.label, required this.quantity});

  @override
  Widget build(BuildContext context) {
    const bool isDarkMode =
        false; // Remplacez cette logique par votre gestion de thème
    const Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color quantityColor = quantity < 100 ? Colors.red : Colors.green;

    // Sélection d'icône en fonction de la quantité
    final IconData icon = quantity < 100
        ? Icons.inventory_2_rounded // Petite bouteille
        : Icons.inventory_2_rounded; // Grande bouteille

    // Dimensions adaptatives
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth * 0.85; // 85% de la largeur de l'écran

    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 10.0, horizontal: 16.0), // Espacement entre les cartes
      child: Card(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: cardWidth,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icône en haut
              Icon(
                icon,
                size: 50,
                color: isDarkMode ? Colors.amber : Colors.blue,
              ),
              const SizedBox(height: 8),

              // Étiquette
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),

              // Quantité
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 500),
                child: Text(
                  '$quantity',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: quantityColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddGasFormPage extends StatefulWidget {
  const AddGasFormPage({super.key});

  @override
  _AddGasFormPageState createState() => _AddGasFormPageState();
}

class _AddGasFormPageState extends State<AddGasFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _gasNameController = TextEditingController();
  final TextEditingController _smallBottlesController = TextEditingController();
  final TextEditingController _largeBottlesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const bool isDarkMode =
        false; // Remplacez cette logique par votre gestion de thème

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajouter du Gaz',
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: isDarkMode ? Colors.black : const Color(0xFFEAEAEA),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Pour que la colonne prenne seulement l'espace nécessaire
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Formulaire d\'ajout de Gaz',
                  style: GoogleFonts.poppins(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),

                // Champ pour le nom du gaz
                TextFormField(
                  controller: _gasNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nom du Gaz',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un nom de gaz';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Champ pour les petites bouteilles
                TextFormField(
                  controller: _smallBottlesController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Petites Bouteilles',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer la quantité de petites bouteilles';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Veuillez entrer un nombre valide pour les petites bouteilles';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Champ pour les grandes bouteilles
                TextFormField(
                  controller: _largeBottlesController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Grandes Bouteilles',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer la quantité de grandes bouteilles';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Veuillez entrer un nombre valide pour les grandes bouteilles';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Bouton pour ajouter le gaz après validation
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Si la validation passe, vous pouvez soumettre le formulaire
                      String gasName = _gasNameController.text;
                      int smallBottles =
                          int.parse(_smallBottlesController.text);
                      int largeBottles =
                          int.parse(_largeBottlesController.text);

                      // Logique pour soumettre le formulaire
                      // Par exemple, enregistrer les données ou effectuer une action
                      print('Gaz: $gasName');
                      print('Petites Bouteilles: $smallBottles');
                      print('Grandes Bouteilles: $largeBottles');

                      // Afficher un message de succès ou naviguer
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Gaz ajouté avec succès')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .green, // Définir la couleur d'arrière-plan sur vert
                  ),
                  child: Text(
                    'Ajouter le Gaz',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const bool isDarkMode =
        false; // Remplacez cette logique par votre gestion de thème

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mes Notes',
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
            icon: const Icon(
              Icons.notifications,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: 10, // Nombre de notes
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'John Pascal', // Nom de l'utilisateur
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.yellow : Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      '4 étoiles', // Note de l'utilisateur
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController locationController = TextEditingController();
    const bool isDarkMode =
        false; // Remplacez par votre gestion de thème si nécessaire

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Changer mon emplacement',
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
            icon: const Icon(
              Icons.notifications,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Entrez votre nouvel emplacement',
                labelStyle: GoogleFonts.poppins(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              ),
              style: GoogleFonts.poppins(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Logique de soumission
                String newLocation = locationController.text;
                if (newLocation.isNotEmpty) {
                  // Afficher un message ou effectuer une action
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Emplacement défini sur : $newLocation',
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  );
                  // Retourner à la page précédente
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Veuillez entrer un emplacement valide.',
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: Text(
                'Définir',
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
    );
  }
}

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    const bool isDarkMode = false; // Remplacez avec votre gestion de thème

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gestion des livreurs',
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
            icon: const Icon(
              Icons.notifications,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          // Centrer les éléments dans le body
          child: Column(
            mainAxisSize: MainAxisSize
                .min, // Centrer le contenu sans prendre toute la hauteur
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 4, // Remplacez par la liste réelle des livreurs
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Livreur ${index + 1}', // Nom du livreur
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Logique pour supprimer un livreur
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Supprimer',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // Le bouton flottant sera aligné à droite
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddDeliveryPersonPage(),
            ),
          );
        },
        backgroundColor: isDarkMode ? Colors.yellow : Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

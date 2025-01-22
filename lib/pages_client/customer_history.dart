import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:egaz/autres_pages/theme_provider.dart';

class PurchaseHistoryPage extends StatelessWidget {
  const PurchaseHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        title: Text(
          "Historique d'achats",
          style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.bold,color:Colors.black),
        ),
       centerTitle: true,
      ),
      backgroundColor: themeProvider.isDarkMode ? Colors.black : const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [ 
            // Filtre ou barre de recherche
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: themeProvider.isDarkMode ? Colors.grey[800] : Colors.white,
                hintText: "Rechercher un achat...",
                hintStyle: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.grey[400] : Colors.grey[700],
                ),
                prefixIcon: Icon(Icons.search, color: themeProvider.isDarkMode ? Colors.white : Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Liste des achats
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Remplacez par le nombre d'achats réels
                itemBuilder: (context, index) {
                  return Card(
                    color: themeProvider.isDarkMode ? Colors.grey[900] : Colors.white,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: themeProvider.isDarkMode ? Colors.grey[800] : Colors.blue,
                        child: const Icon(Icons.shopping_bag, color: Colors.white),
                      ),
                      title: Text(
                        "Produit ${index + 1}",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        "Date : ${DateTime.now().subtract(Duration(days: index)).toLocal()}",
                        style: TextStyle(
                          color: themeProvider.isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      trailing: Text(
                        "\$${(index + 1) * 10}.00",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: themeProvider.isDarkMode ? Colors.green : Colors.blue,
                        ),
                      ),
                      onTap: () {
                        // Naviguer vers les détails de l'achat
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "Détails de l'achat",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                "Produit ${index + 1}\nDate : ${DateTime.now().subtract(Duration(days: index)).toLocal()}\nPrix : \$${(index + 1) * 10}.00\nStatut : Livré",
                                style: GoogleFonts.poppins(),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Fermer"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

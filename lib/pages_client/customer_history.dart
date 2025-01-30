import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class PurchaseHistoryPage extends StatelessWidget {
  const PurchaseHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
       
        title: Text(
          "Historique d'achats",
          style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.bold,color:Colors.black),
        ),
       centerTitle: true,
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [ 
           
            TextField(
              decoration: InputDecoration(
                filled: true,
               
                hintText: "Rechercher un achat...",
                hintStyle: TextStyle(
                 
                ),
                prefixIcon: Icon(Icons.search, ),
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
                    
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        child:  Icon(Icons.shopping_bag, color: Colors.white),
                      ),
                      title: Text(
                        "Produit ${index + 1}",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                         
                        ),
                      ),
                      subtitle: Text(
                        "Date : ${DateTime.now().subtract(Duration(days: index)).toLocal()}",
                        style: TextStyle(
                         
                        ),
                      ),
                      trailing: Text(
                        "\$${(index + 1) * 10}.00",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          
                        ),
                      ),
                      onTap: () {
                       
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

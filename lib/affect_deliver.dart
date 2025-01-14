import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:egaz/seller_screen.dart';

class AffectDeliver extends StatefulWidget {
  const AffectDeliver({super.key});

  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class _SellerScreenState extends State<AffectDeliver> {
  bool isDarkMode = false;
  int selectedIndex = 0; 
  bool showPopup = false;
  String? selectedLivreur;

  // Ici il faut mettre la liste des livreurs que lapi va fournir 
  List<String> livreurs = [
    "Ahmed Diouf",
    "Fatou Ndiaye",
    "Moussa Ba",
    "Aminata Sy",
    "Seydou Sall",
  ];

  void _showPopup(String livreur) {
    setState(() {
      selectedLivreur = livreur;
      showPopup = true;
    });
  }

  void _hidePopup() {
    setState(() {
      showPopup = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          'Affectation de livreur',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.black : const Color(0xFFEAEAEA),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                key: ValueKey<bool>(isDarkMode),
                color: isDarkMode ? Colors.yellow : Colors.black,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(livreurs.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    title: Text(
                      livreurs[index],
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _showPopup(livreurs[index]);
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                          ),
                          child: Text(
                            'Affecter',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[900] : Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(Icons.near_me, 'Commandes', 0),
              _buildNavItem(Icons.store, 'Ma boutique', 1),
              _buildNavItem(Icons.person, 'Profil', 2),
            ],
          ),
        ),
      ),
    
      floatingActionButton: showPopup
          ? GestureDetector(
              onTap: _hidePopup,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'La livraison vient d\'être affectée à :',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            selectedLivreur ?? '',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.yellow : Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {}, 
                            child: ElevatedButton(
                              onPressed: () {
                                    Navigator.push(
                                 context,
                                   MaterialPageRoute(
                                    builder: (context) => const SellerScreen(),
                                    ),);
                              },
                              child: Text(
                                'OK',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Container(),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isActive = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive
                ? (isDarkMode ? Colors.yellow : Colors.blue)
                : (isDarkMode ? Colors.white : Colors.black),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: isActive
                  ? (isDarkMode ? Colors.yellow : Colors.blue)
                  : (isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

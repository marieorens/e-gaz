import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:egaz/order_details.dart';
class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  bool isDarkMode = false;
  int selectedIndex = 0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          'Commandes en cours',
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
            children: List.generate(5, (index) {
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
    index % 2 == 0 ? 'Petit gaz Oryx' : 'Grand gaz Oryx',
    style: GoogleFonts.poppins(
      color: isDarkMode ? Colors.white : Colors.black,
    ),
  ),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        '${index + 1}',
        style: GoogleFonts.poppins(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      const SizedBox(width: 12),
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OrderDetailPage(),
            ),
          );
        },
        icon: Icon(
          Icons.visibility,
          color: isDarkMode ? Colors.white : Colors.black,
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
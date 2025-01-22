import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:egaz/theme_provider.dart';
import 'package:egaz/profilempodificationpage.dart';
import 'package:egaz/login_screen.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: themeProvider.isDarkMode ? Colors.grey[800] : Colors.grey[300],
              child: const Icon(
                Icons.add,
                size: 30,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Johnny Shop",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            _buildButton(
              context: context,
              icon: Icons.edit,
              label: "Modifier mon profil",
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              onTap: () {
               Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileModificationPage(),
                            ),
                          );
              },
            ),
            const SizedBox(height: 15),
            _buildButton(
              context: context,
              icon: Icons.logout,
              label: "Déconnexion",
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              onTap: () {
                 Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
              },
            ),
            
           
            const SizedBox(height: 15),
            _buildButton(
              context: context,
              icon: Icons.delete,
              label: "Supprimer mon compte",
              color: Colors.red,
              onTap: () {
                // Action pour supprimer le compte
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: themeProvider.isDarkMode ? Colors.black45 : Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:egaz/autres_pages/theme_provider.dart';
import 'package:egaz/autres_pages/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:egaz/pages_authentification/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeProvider.isDarkMode
                ? ThemeData.dark().copyWith(
                    appBarTheme: AppBarTheme(
                      backgroundColor: Colors.black,
                      iconTheme: const IconThemeData(color: Colors.white),
                      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                : ThemeData.light().copyWith(
                    appBarTheme: AppBarTheme(
                      backgroundColor: Colors.white,
                      iconTheme: const IconThemeData(color: Colors.black),
                      titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
 
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email); // Envoi de l'email de réinitialisation
      return null; // Aucun erreur
    } catch (e) {
      return e.toString(); // Retourne l'erreur si elle existe
    }
  }

  Future<String?> signup({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
     
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name.trim(),
        'email': email.trim(),
        'role': role, 
      });

      return null; 
    } catch (e) {
      return e.toString(); 
    }
  }

  
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      return userDoc['role']; 
    } catch (e) {
      return e.toString(); 
    }
  }

 
  signOut() async {
    _auth.signOut();
  }
}


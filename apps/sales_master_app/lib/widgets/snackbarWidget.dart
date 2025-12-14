import 'package:flutter/material.dart';
import 'package:get/get.dart';

// --- SNACKBAR HELPER CLASS ---
// Cette classe statique contient des méthodes pour afficher des SnackBars stylisées 
// dans l'ensemble de l'application sans avoir besoin de 'context'.
class SnackBarHelper {
  
  // Méthode pour afficher un message de succès
  static void showSuccess(String title, String message) {
    Get.snackbar(
      title, // Titre dynamique
      message, // Message dynamique
      icon: const Icon(Icons.check_circle, color: Colors.red, size: 30),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade50,
      borderRadius: 12,
      borderColor: Colors.red,        
    borderWidth: 1,                
      margin: const EdgeInsets.all(16),
      colorText: Colors.red,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      // Utilisation de messageText pour un style de message plus contrôlé
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 16,
        ),
      ),
      // Utilisation de titleText pour un style de titre plus contrôlé
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  // Exemple d'une méthode pour afficher un message d'erreur
  static void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      icon: const Icon(Icons.error, color: Colors.white, size: 30),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.shade700,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
      isDismissible: true,
      forwardAnimationCurve: Curves.fastOutSlowIn,
    );
  }
}
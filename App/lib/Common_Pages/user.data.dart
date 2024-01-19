import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String _userId = '';

  String get userId => _userId;

  set userId(String newUserId) {
    _userId = newUserId;
    // Notify listeners when the user ID changes
    notifyListeners();
  }

  // Add this method to fetch userId
  Future<String> fetchUserId() async {
    // You can add any logic here to fetch the user ID
    // For now, let's return a sample user ID
    return 'sampleUserId';
  }
}

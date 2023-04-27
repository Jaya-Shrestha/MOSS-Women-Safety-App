import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Confession with ChangeNotifier {
  final String id;
  final String description;
  bool isLiked;

  Confession({
    required this.id,
    required this.description,
    this.isLiked = false,
  });
  void _setLikeValue(bool newValue) {
    isLiked = newValue;
    notifyListeners();
  }

  Future<void> toggleLikedStatus() async {
    final oldStatus = isLiked;
    isLiked = !isLiked;
    notifyListeners();
    final url = Uri.parse(
        'https://riderapp-e40ec-default-rtdb.firebaseio.com/confessions/$id.json');
    try {
      final response = await http.patch(url,
          body: json.encode({
            'isLiked': isLiked,
          }));
      if (response.statusCode >= 400) {
        _setLikeValue(oldStatus);
      }
    } catch (error) {
      _setLikeValue(oldStatus);
    }
  }
}

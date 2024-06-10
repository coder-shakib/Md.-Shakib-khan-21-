import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsProvider with ChangeNotifier {
  List _newsArticles = [];
  bool _isLoading = false;
  String _selectedCountry = 'us';
  String _selectedCategory = 'world';

  List get newsArticles => _newsArticles;
  bool get isLoading => _isLoading;
  String get selectedCountry => _selectedCountry;
  String get selectedCategory => _selectedCategory;

  void setSelectedCountry(String country) {
    _selectedCountry = country;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> fetchNews({required String keyword, required String name}) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
        'https://newsdata.io/api/1/latest?country=$_selectedCountry&category=$_selectedCategory&apikey=pub_45808d5ecdf6b2b576008c91ed2d00016de03&q=$keyword');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _newsArticles = data['results'];
    } else {
      _newsArticles = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}

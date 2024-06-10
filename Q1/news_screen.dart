import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late TextEditingController _keywordController;
  late TextEditingController _dateController;
  late String _selectedLanguage;
  late String _selectedSorting;
  List<dynamic> _news = [];

  @override
  void initState() {
    super.initState();
    _keywordController = TextEditingController();
    _dateController = TextEditingController();
    _selectedLanguage = 'en';
    _selectedSorting = 'publishedAt';
  }

  Future<void> _searchNews() async {
    final String keyword = _keywordController.text;
    final String date = _dateController.text;

    final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=$keyword&from=$date&language=$_selectedLanguage&sortBy=$_selectedSorting&apiKey=2212928139c44403b798c0e21d642581'));
    
    if (response.statusCode == 200) {
      setState(() {
        _news = json.decode(response.body)['articles'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Search'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _keywordController,
              decoration: InputDecoration(labelText: 'Keywords'),
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
              },
              items: ['ar', 'de', 'en'].map((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(lang),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Language'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedSorting,
              onChanged: (value) {
                setState(() {
                  _selectedSorting = value!;
                });
              },
              items: ['relevancy', 'popularity', 'publishedAt'].map((sort) {
                return DropdownMenuItem(
                  value: sort,
                  child: Text(sort),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Sort By'),
            ),
            ElevatedButton(
              onPressed: _searchNews,
              child: Text('Search News'),
            ),
            SizedBox(height: 20),
            _news.isNotEmpty ? ListView.builder(
              shrinkWrap: true,
              itemCount: _news.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_news[index]['title']),
                  subtitle: Text(_news[index]['description']),
                );
              },
            ) : Container(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _keywordController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}

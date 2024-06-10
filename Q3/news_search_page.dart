import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'news_provider.dart'; // Assuming the NewsProvider code is in this file

class NewsSearchPage extends StatelessWidget {
  final TextEditingController _keywordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Country-Based News App by tahura 4'),
      ),
      body: Container(
        color: Colors.lightBlueAccent, // Set your desired background color here
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _keywordController,
              decoration: InputDecoration(labelText: 'Keyword'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: newsProvider.selectedCountry,
              onChanged: (String? newValue) {
                newsProvider.setSelectedCountry(newValue!);
              },
              items: <String>['bd', 'de', 'in', 'us']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: newsProvider.selectedCategory,
              onChanged: (String? newValue) {
                newsProvider.setSelectedCategory(newValue!);
              },
              items: <String>[
                'education',
                'food',
                'health',
                'politics',
                'science',
                'technology',
                'world'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                newsProvider.fetchNews(
                  keyword: _keywordController.text,
                  name: _nameController.text,
                );
              },
              child: Text('Search Country News By ${_nameController.text} 4'),
            ),
            Expanded(
              child: newsProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: newsProvider.newsArticles.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(newsProvider.newsArticles[index]['title']),
                          subtitle: Text(newsProvider.newsArticles[index]['description'] ?? ''),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

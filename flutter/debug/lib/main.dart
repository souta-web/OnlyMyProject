import 'package:flutter/material.dart';
import 'database_helper.dart'; 
import 'search_database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  String _searchMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('データベース検索'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: '検索キーワードを入力してください',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // 検索ボタンがクリックされたとき、検索を実行
                String keyword = _searchController.text;
                List<Map<String, dynamic>> results =
                    await SearchDatabase().search(keyword);
                setState(() {
                  _searchResults = results;
                  if (_searchResults.isEmpty) {
                    _searchMessage = '一致する検索ワードがありません';
                  } else {
                    _searchMessage = '';
                  }
                });
              },
              child: Text('検索'),
            ),
            SizedBox(height: 16.0),
            Text(_searchMessage),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('検索結果 ${index + 1}'),
                    subtitle: Text(_searchResults[index].toString()),
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

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InputScreen(),
    );
  }
}

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _savedTexts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('テキスト入力と保存'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'テキストを入力してください'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveText,
              child: Text('保存'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _savedTexts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_savedTexts[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveText() async {
    final text = _textController.text.trim();

    if (text.isNotEmpty) {
      await _insertTextToDatabase(text);
      _textController.clear();
      _refreshSavedTexts();
    }
  }

  Future<void> _insertTextToDatabase(String text) async {
    final database = await _initDatabase();
    await database.insert(
      'texts',
      {'content': text},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'text_database.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE texts(id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> _refreshSavedTexts() async {
    final database = await _initDatabase();
    final List<Map<String, dynamic>> maps = await database.query('texts');
    final List<String> savedTexts =
        List.generate(maps.length, (index) => maps[index]['content']);
    setState(() {
      _savedTexts.clear();
      _savedTexts.addAll(savedTexts);
    });
  }
}

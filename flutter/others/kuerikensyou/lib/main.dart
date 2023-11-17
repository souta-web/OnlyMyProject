import 'package:flutter/material.dart';
import 'database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _incrementCounter() async {
    final DatabaseHelper dbHelper = DatabaseHelper.instance;
    Map<String, dynamic> row = {
      DatabaseHelper.columnChatSender: "true",
      DatabaseHelper.columnChatTodo: "true",
      DatabaseHelper.columnChatTodofinish: "true",
      DatabaseHelper.columnChatMessage: "こんにちは",
      DatabaseHelper.columnChatTime: chatTime,
      DatabaseHelper.columnChatChannel: chatChannel,
      DatabaseHelper.columnChatActionId: chatActionId,
    };

    await dbHelper.insert_chat_table(row);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () { /* ボタンが押せる時 */ },
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text('登録'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
      ),
    );
  }
}

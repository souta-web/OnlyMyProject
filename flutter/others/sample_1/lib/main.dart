import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    _controller.addListener(() {
      final text = _controller.text;
      print('TextEditingControllerの値が変更されました: $text');
    });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('TextEditingControllerの変更検知'),
        ),
        body: Center(
          child: TextField(
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
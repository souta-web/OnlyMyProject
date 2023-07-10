import 'package:flutter/material.dart';
import 'config.dart';

class ChatScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfigScreenWidget()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Chat Screen'),
      ),
    );
  }
}
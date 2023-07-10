import 'package:flutter/material.dart';
import 'config.dart';

class TimelineScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timeline'),
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
        child: Text('Timeline Screen'),
      ),
    );
  }
}
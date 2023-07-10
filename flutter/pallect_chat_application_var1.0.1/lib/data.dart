import 'package:flutter/material.dart';
import 'config.dart';

class DataScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
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
        child: Text('Data Screen'),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ConfigScreenWidget extends StatefulWidget {
  @override
  _ConfigScreenWidgetState createState() => _ConfigScreenWidgetState();
}

class _ConfigScreenWidgetState extends State<ConfigScreenWidget> {
  bool _toggleValue = false;

  void _toggleButton(bool value) {
    setState(() {
      _toggleValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Config'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: Text('ダークモード'),
            value: _toggleValue,
            onChanged: (value) {
              _toggleButton(value);
            },
          ),
        ],
      ),
    );
  }
}

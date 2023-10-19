import 'package:flutter/material.dart';
import 'list_class.dart';

class Button3 extends StatefulWidget {
  final ListA listA;
  final VoidCallback onPressed;

  Button3(this.listA,this.onPressed);

  @override
  _Button3State createState() => _Button3State();
}

class _Button3State extends State<Button3> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:widget.onPressed,
      child: Text('Button3:list_a削除'),
    );
  }
}
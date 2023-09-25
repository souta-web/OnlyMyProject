import 'package:flutter/material.dart';
import 'list_class.dart';

class Button3 extends StatefulWidget {
  final ListA listA;

  Button3(this.listA);

  @override
  _Button3State createState() => _Button3State();
}

class _Button3State extends State<Button3> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // ボタン3が押された時の処理
        widget.listA.count -= 1;
        widget.listA.list_A.removeLast();
        setState(() {});
      },
      child: Text('list_a削除'),
    );
  }
}
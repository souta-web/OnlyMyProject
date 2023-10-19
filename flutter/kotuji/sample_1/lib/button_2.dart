import 'package:flutter/material.dart';
import 'list_class.dart';

class Button2 extends StatefulWidget {
  final ListA listA;

  Button2(this.listA);

  @override
  _Button2State createState() => _Button2State();
}

class _Button2State extends State<Button2> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // ボタン2が押された時の処理
        widget.listA.count += 1;
        widget.listA.list_A.add(widget.listA.count.toString());
        print("list_a:" + widget.listA.list_A.toString());
        setState(() {});
      },
      child: Text('Button2:list_a追加'),
    );
  }
}
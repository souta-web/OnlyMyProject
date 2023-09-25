import 'package:flutter/material.dart';
import 'list_class.dart';

class DrawListIndex extends StatefulWidget {
  final ListA listA;

  DrawListIndex(this.listA);

  @override
  _DrawListIndex createState() => _DrawListIndex();
}

class _DrawListIndex extends State<DrawListIndex> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.listA.count.toString(),
    );
  }
}
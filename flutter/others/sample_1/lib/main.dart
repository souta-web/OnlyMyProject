import 'package:flutter/material.dart';
import 'list_class.dart';
import 'button_3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Vertical Buttons'),
        ),
        body: BodyWidget(),
      ),
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {

  late ListA listA = ListA();
  late Button3 button3;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              // ボタン1が押された時の処理
              List<String> _data = listA.list_A;
              print("list_a:$_data");
            },
            child: Text('list_a出力'),
          ),
          SizedBox(height: 20), // ボタンとボタンの間にスペースを空ける
          ElevatedButton(
            onPressed: () {
              // ボタン2が押された時の処理
              listA.count += 1;
              listA.list_A.add(listA.count.toString());
            },
            child: Text('list_a追加'),
          ),
          SizedBox(height: 20), // ボタンとボタンの間にスペースを空ける
          button3 = Button3(listA),
        ],
      ),
    );
  }
}
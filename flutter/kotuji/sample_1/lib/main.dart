import 'package:flutter/material.dart';
import 'list_class.dart';
import 'button_3.dart';
import 'button_2.dart';
import 'draw_list_index.dart';

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
  late Button2 button2;
  late List<String> _data = listA.list_A;

  void button3Pressed() {
    // ボタン3が押された時の処理
    listA.count -= 1;
    listA.list_A.removeLast();
    print("list_a:$_data");
    setState(() {});
  }

  @override

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              // ボタン1が押された時の処理
              print("list_a:$_data");
              setState(() {});
            },
            child: Text('list_a出力のみ'),
          ),
          SizedBox(height: 20), // ボタンとボタンの間にスペースを空ける
          button2 = Button2(listA),
          SizedBox(height: 20), // ボタンとボタンの間にスペースを空ける
          button3 = Button3(listA,button3Pressed),
          SizedBox(height: 20), // ボタンとボタンの間にスペースを空ける
          DrawListIndex(listA),
        ],
      ),
    );
  }
}
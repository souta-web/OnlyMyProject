import 'package:flutter/material.dart';

class ChatTodo extends StatefulWidget {
  const ChatTodo({
    Key? key,
  }) : super(key: key);

  @override
  _ChatTodoState createState() => _ChatTodoState();
}

class _ChatTodoState extends State<ChatTodo> {
  var _now, _year, _month, _day, _hour, _minute, _second;

  void _timeLog() {
    setState(() {
      _now = DateTime.now();
      _year = _now.year;
      _month = _now.month;
      _day = _now.day;
      _hour = _now.hour;
      _minute = _now.minute;
      _second = _now.second;
    });
  }

  //class ChatTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('todo')),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            padding: EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 170, 167, 167),
            ),
            child: Column(children: [Text(_now)]),
          ),
        ],
      ),
    );
  }
}

/*boxShadow: [
  BoxShadow(
      color: Color.fromARGB(255, 206, 202, 202),
      blurRadius: 3.0,
      spreadRadius: 1.0,
      offset: Offset(3, 3))
],*/



      
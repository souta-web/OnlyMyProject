import 'package:flutter/material.dart';

class ChatTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Color.fromARGB(255, 229, 229, 229),
          margin: EdgeInsets.symmetric(vertical: 20.0),
          padding: EdgeInsets.all(7.0),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Text(
                      '12:03　',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '行動１',
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          '生活',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 11.0,
                            backgroundColor: Color.fromARGB(255, 134, 218, 239),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Material(
                color: Color.fromARGB(255, 229, 229, 229),
                child: Center(
                  child: Ink(
                    child: IconButton(
                      icon: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/play_circle.png'),
                        backgroundColor: Colors.transparent, // 背景色
                        radius: 25,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              )
            ]
          ),
        ),
      ],
    );
  }
}
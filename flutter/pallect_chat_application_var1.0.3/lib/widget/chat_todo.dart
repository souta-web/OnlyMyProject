import 'package:flutter/material.dart';

class ChatTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('todo')),
      body: Column(
        children: [
          Container(
            color: Color.fromARGB(255, 207, 203, 203),
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
                                backgroundColor:
                                    Color.fromARGB(255, 134, 218, 239),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: Color.fromARGB(255, 207, 203, 203),
                    child: Center(
                      child: Ink(
                        child: IconButton(
                          icon: Icon(Icons.play_circle_outline),
                          iconSize: 40.0,
                          color: const Color.fromARGB(255, 25, 25, 25),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
//import 'package:bubble/issue_clipper.dart';

/*class ChatFukidashi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('fukidashi')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 17.0,
                  vertical: 25.0,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 28.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            color: Color.fromARGB(255, 255, 191, 114),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text('行動１を開始'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

class ChatFukidashi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fukidashi'),
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(6),
          children: [
            Bubble(
              margin: BubbleEdges.all(10.0),
              padding: BubbleEdges.all(14.0),
              radius: Radius.circular(10.0),
              alignment: Alignment.topRight,
              stick: true,
              nip: BubbleNip.rightBottom,
              color: Color.fromARGB(255, 255, 191, 114),
              child: Text(
                '行動１を開始',
                style: TextStyle(fontSize: 13.0),
              ),
            ),
            Bubble(
              margin: BubbleEdges.all(10.0),
              padding: BubbleEdges.all(14.0),
              radius: Radius.circular(10.0),
              alignment: Alignment.topLeft,
              stick: true,
              nip: BubbleNip.leftBottom,
              color: Color.fromARGB(255, 207, 203, 203),
              child: Text(
                '行動１を開始しました。頑張ってください！',
                style: TextStyle(fontSize: 13.0),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 25.0,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 28.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            color: Color.fromARGB(255, 255, 191, 114),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              '行動１を開始',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

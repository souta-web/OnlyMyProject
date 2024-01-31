import 'package:flutter/material.dart';
import '../func/action_registration_base.dart';

class TimeLineTopBar extends StatefulWidget {
  TimeLineTopBar({required this.topBarWidth,required this.topBarHeight,required this.timelineActionsData});
  //bodyのサイズを受け取る
  final double topBarWidth;
  final double topBarHeight;
  final TimeLineActionsData timelineActionsData;

  @override
  _TimeLineTopBar createState() => _TimeLineTopBar();
}

class _TimeLineTopBar extends State<TimeLineTopBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: widget.topBarWidth,
      height: widget.topBarHeight,
      child:Stack(
      alignment: Alignment.topCenter,
      children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    print('Search button pressed!');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    print('Add button pressed!');
                    print("widget");
                    print(widget.timelineActionsData.defaultData);
                  },
                ),
              ],
            ),
      ]
      )
    );
  }
}
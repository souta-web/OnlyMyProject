import 'package:flutter/material.dart';
import 'widget/time_line_base.dart';

class DataScreenWidget extends StatefulWidget {
  @override
  _DataScreenWidgetState createState() => _DataScreenWidgetState();
}

class _DataScreenWidgetState extends State<DataScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/config');
            },
          ),
        ],
      ),
      body:TimeLineBody(),
      floatingActionButton: WidgetFloatingActionButton(),
    );
  }
}

class TimeLineBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // constraintsはbodyのサイズを表すBoxConstraintsです。
        final _bodyWidth = constraints.maxWidth; //bodyの横幅取得
        final _bodyHeight = constraints.maxHeight; //bodyの縦幅を取得
        return Center(
          child:SingleChildScrollView(
            child:TimeLineBase(bodyWidth: _bodyWidth,bodyHeight: _bodyHeight,)
          )
        );
      },
    );
  }
}

//右下のボタン作成
class WidgetFloatingActionButton extends StatefulWidget {
  @override
  _WidgetFloatingActionButton createState() => _WidgetFloatingActionButton();
}

class _WidgetFloatingActionButton extends State<WidgetFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // ボタンが押されたときの処理を記述
        setState(() {
          print("tap");
        });
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.blue, // FABの背景色を変更
    );
  }
}
import 'package:flutter/material.dart';
import '/screen/action_edit/widget/field_widgets.dart';

class ActionEditPage extends StatefulWidget {
  @override
  _ActionEditPage createState() => _ActionEditPage();
}

class _ActionEditPage extends State<ActionEditPage> {

  @override

  void initState() {
    super.initState();
    // 初期化の処理をここに記述する
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('アクション編集'),
        //automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.grading),
            onPressed: () {
            },
          ),
        ],
      ),
      body: ActionEditPageBody()
    );
  }
}

class ActionEditPageBody extends StatefulWidget {
  @override
  _ActionEditPageBody createState() => _ActionEditPageBody();
}

class _ActionEditPageBody extends State<ActionEditPageBody> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // constraintsはbodyのサイズを表すBoxConstraintsです。
        final _bodyWidth = constraints.maxWidth; //bodyの横幅取得
        final _bodyHeight = constraints.maxHeight; //bodyの縦幅を取得
        return Column(
          children:[
            ActionEditPagePrimaryWidget(bodyWidth: _bodyWidth,bodyHeight: _bodyHeight)
          ]
        );
      },
    );
  }
}

import 'package:action_detail_and_edit_page/screen/action_edit/widget/field_datas.dart';
import 'package:flutter/material.dart';
import 'widget/screen_body.dart';
import '/screen/action_edit/func/save_button_pressed.dart';
import 'func/set_initial_data.dart';

class ActionEditPage extends StatefulWidget {
  @override
  _ActionEditPage createState() => _ActionEditPage();
}

class _ActionEditPage extends State<ActionEditPage> {
  SaveButtonPressed saveButtonPressed = SaveButtonPressed();
  late SetInitialData setInitialData;
  late FieldDatas fieldDatas = FieldDatas();
  @override
  
  void initState() {
    super.initState();
    // 初期化の処理をここに記述する
    setInitialData = SetInitialData(fieldDatas);
    setInitialData.setData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('アクション編集'),
        //automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.grading),
            onPressed: () { //右上の保存ボタンが押されたときの動作
              saveButtonPressed.dataOutPut(fieldDatas.title,
                                           fieldDatas.tags,
                                           fieldDatas.startTime,
                                           fieldDatas.endTime,
                                           fieldDatas.score,
                                           fieldDatas.note
              );
            },
          ),
        ],
      ),
      body: ActionEditPageBody(fieldDatas)
    );
  }
}

class ActionEditPageBody extends StatefulWidget {
  final FieldDatas fieldDatas;

  ActionEditPageBody(this.fieldDatas);
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
            ActionEditPagePrimaryWidget(bodyWidth: _bodyWidth,bodyHeight: _bodyHeight,fieldDatas: widget.fieldDatas,)
          ]
        );
      },
    );
  }
}

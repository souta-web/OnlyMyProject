import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'field_datas.dart';
import '/widget/create_horizontal_line.dart';
import 'area_title.dart';
import 'area_tag.dart';
//import 'package:table_calendar/table_calendar.dart';


class ActionEditPagePrimaryWidget extends StatefulWidget {
  ActionEditPagePrimaryWidget({required this.bodyWidth,required this.bodyHeight,required this.fieldDatas});
  final double bodyWidth;
  final double bodyHeight;
  final FieldDatas fieldDatas;
  @override
  _ActionEditPagePrimaryWidget createState() => _ActionEditPagePrimaryWidget();
}

class _ActionEditPagePrimaryWidget extends State<ActionEditPagePrimaryWidget> {
  //テキストコントローラーの作成。テキストフィールドの値はこれで取得することができる
  final TextEditingController _textEditingControllerTitle = TextEditingController();
  final TextEditingController _textEditingControllerScore = TextEditingController();
  final TextEditingController _textEditingControllerExplain = TextEditingController();
  final TextfieldTagsController _textFieldTagsController = TextfieldTagsController(); //タグフィールドのコントローラー

  late double _deviceWidth = MediaQuery.of(context).size.width; //画面の横幅を取得

  //変数関係
  late TitleArea titleArea;
  late TagArea tagArea;
  
  @override
  void initState() {
    super.initState();
    
  }
  
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children: [
          titleArea = TitleArea(deviceWidth: _deviceWidth,textEditingControllerTitle: _textEditingControllerTitle,fieldDatas: widget.fieldDatas,),
          tagArea = TagArea(deviceWidth: _deviceWidth,textFieldTagsController: _textFieldTagsController,fieldDatas: widget.fieldDatas,),
          //_createCalenderArea(),
        ]
      )
    );
  }
}
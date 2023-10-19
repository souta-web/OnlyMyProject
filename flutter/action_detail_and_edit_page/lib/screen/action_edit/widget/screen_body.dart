import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'field_datas.dart';
import 'area_title.dart';
import 'area_tag.dart';
import 'area_date_and_time.dart';
import 'area_score.dart';
import 'area_note.dart';
//import 'package:table_calendar/table_calendar.dart';


class ActionEditPagePrimaryWidget extends StatefulWidget {
  ActionEditPagePrimaryWidget({required this.bodyWidth,required this.bodyHeight,required this.fieldDatas});
  final double bodyWidth;
  final double bodyHeight;
  final FieldDatas fieldDatas; //編集画面の編集可能エリアフィールドの変数が格納されているインスタンス済みクラス。
  @override
  _ActionEditPagePrimaryWidget createState() => _ActionEditPagePrimaryWidget();
}

class _ActionEditPagePrimaryWidget extends State<ActionEditPagePrimaryWidget> {
  //テキストコントローラーの作成。テキストフィールドの値はこれで取得することができる
  final TextfieldTagsController _textFieldTagsController = TextfieldTagsController(); //タグフィールドのコントローラー

  late double _deviceWidth = MediaQuery.of(context).size.width; //画面の横幅を取得

  
  //編集可能エリアのクラスのインスタンス化
  late TitleArea titleArea;
  late TagArea tagArea;
  late DateAndTimeArea dateAndTimeArea;
  late ScoreArea scoreArea;
  late NoteArea noteArea;

  @override
  void initState() {
    super.initState();
  }
  
  //編集エリアを縦に並べる
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children: [
          titleArea = TitleArea(deviceWidth: _deviceWidth,fieldDatas: widget.fieldDatas,),
          tagArea = TagArea(deviceWidth: _deviceWidth,textFieldTagsController: _textFieldTagsController,fieldDatas: widget.fieldDatas,),
          dateAndTimeArea = DateAndTimeArea(deviceWidth: _deviceWidth,fieldDatas: widget.fieldDatas,),
          scoreArea = ScoreArea(deviceWidth: _deviceWidth,fieldDatas: widget.fieldDatas,),
          noteArea = NoteArea(deviceWidth: _deviceWidth,fieldDatas: widget.fieldDatas,),
        ]
      )
    );
  }
}
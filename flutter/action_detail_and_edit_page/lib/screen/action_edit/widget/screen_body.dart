import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'field_datas.dart';
import '/widget/create_horizontal_line.dart';
import 'area_title.dart';
import 'area_tag.dart';
import 'area_times.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
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
  final TextEditingController _textEditingControllerTime = TextEditingController();
  final TextEditingController _textEditingControllerExplain = TextEditingController();
  final TextfieldTagsController _textFieldTagsController = TextfieldTagsController(); //タグフィールドのコントローラー

  late double _deviceWidth = MediaQuery.of(context).size.width; //画面の横幅を取得

  //変数関係
  late TitleArea titleArea;
  late TagArea tagArea;
  late TimeArea timeArea;
  
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
          timeArea = TimeArea(deviceWidth: _deviceWidth,textEditingControllerTime: _textEditingControllerTime,fieldDatas: widget.fieldDatas,),
        ]
      )
    );
  }
}
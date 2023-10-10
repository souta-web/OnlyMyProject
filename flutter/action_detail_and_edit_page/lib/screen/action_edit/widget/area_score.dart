import 'package:action_detail_and_edit_page/screen/action_edit/widget/field_datas.dart';
import 'package:flutter/material.dart';
import '/widget/create_horizontal_line.dart';

class ScoreArea extends StatefulWidget {
  final double deviceWidth;
  final FieldDatas fieldDatas;

  ScoreArea({required this.deviceWidth,required this.fieldDatas});

  @override
  _ScoreArea createState() => _ScoreArea();
}

class _ScoreArea extends State<ScoreArea> {
  final TextEditingController _textEditingControllerScore = TextEditingController();
  final double _thisHeight = 70.0;
  static const double _thisTextFieldMargin = 5.0;
  final TextStyle fontData = TextStyle(fontSize: 24);
  
  void initState() {
    super.initState();
    // 初期化の処理をここに記述する
    final String defaultText = widget.fieldDatas.score.toString();
    _textEditingControllerScore.text = defaultText;
  }
    

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.deviceWidth,
      height: _thisHeight,
      child: Container(
        child:Column(
          children: [
            Expanded(
              child:Container(
                //margin: const EdgeInsets.symmetric(horizontal:_thisTextFieldMargin), //ウィジェットの外側の余白
                color: Colors.yellow,
                child: Text("test"),
              ),
            ),
            HorizontalLine(),
          ],
        )
      )
    );
  }
}
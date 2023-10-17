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
  final TextStyle fontData = TextStyle(fontSize: 24);
  
  void initState() {
    super.initState();
    // 初期化の処理をここに記述する
    
  }
    
  @override
  Widget build(BuildContext context) {
    late int thisScore = widget.fieldDatas.score;
    return SizedBox(
      width: widget.deviceWidth,
      //height: _thisHeight,
      child: Container(
        child:Column(
          children: [
            Row(
              children: [
                Text(
                  "スコア：",
                  style: fontData,
                ),
                CreateScoreButton(1,thisScore),
                CreateScoreButton(2,thisScore),
                CreateScoreButton(3,thisScore),
                CreateScoreButton(4,thisScore),
                CreateScoreButton(5,thisScore),
              ],
            ),
            HorizontalLine(),
          ],
        )
      )
    );
  }

  //星のボタンを作る
  Widget CreateScoreButton(int _activeBorder,int _thisActionScore) {
    return IconButton(
      icon: JudgeScoreButtonState(_activeBorder,_thisActionScore)? Icon(Icons.star) : Icon(Icons.star_border),
      onPressed: () {
        // ボタンが押された際の動作を記述する
        widget.fieldDatas.score = _activeBorder;
        setState(() {});
      },
    );
  }

  //アイコンボタンの状態を判定する
  bool JudgeScoreButtonState(int _activeBorder,int _thisActionScore) {
    if (_activeBorder <= _thisActionScore) {
      return true;
    }else{
      return false;
    }
  }
}
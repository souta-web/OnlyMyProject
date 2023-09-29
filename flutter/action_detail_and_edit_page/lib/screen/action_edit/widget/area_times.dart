import 'package:action_detail_and_edit_page/screen/action_edit/widget/field_datas.dart';
import 'package:flutter/material.dart';
import '/widget/create_horizontal_line.dart';

class TimeArea extends StatefulWidget {
  final double deviceWidth;
  final TextEditingController textEditingControllerTime;
  final FieldDatas fieldDatas;

  TimeArea({required this.deviceWidth,required this.textEditingControllerTime,required this.fieldDatas});

  @override
  _TimeArea createState() => _TimeArea();
}

class _TimeArea extends State<TimeArea> {
  final double _thisHeight = 70.0;
  static const Color _hintTextColor = Colors.red;
  static const double _thisTextFieldMargin = 5.0;

  
  void initState() {
    super.initState();
    // 初期化の処理をここに記述する
    final String defaultText = widget.fieldDatas.title.toString();
    widget.textEditingControllerTime.text = defaultText;
  }
    

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.deviceWidth,
      height: _thisHeight,
      child: Container(
        child:Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal:_thisTextFieldMargin), //ウィジェットの外側の余白
              child:TextField(
                controller: widget.textEditingControllerTime,
                decoration: const InputDecoration(
                  hintText: 'タイトル(hintText)', //ヒントテキスト
                  hintStyle: TextStyle(
                    color: _hintTextColor,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 24,
                ),
                onChanged: (value) {
                  // テキストが変更されたときの処理
                  widget.fieldDatas.title = widget.textEditingControllerTime.text;
                },
              ),
            ),
            HorizontalLine(),
          ],
        )
      )
    );
  }
}
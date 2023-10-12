import 'package:action_detail_and_edit_page/screen/action_edit/widget/field_datas.dart';
import 'package:flutter/material.dart';
import '/widget/create_horizontal_line.dart';

class TitleArea extends StatefulWidget {
  final double deviceWidth;
  final FieldDatas fieldDatas;

  TitleArea({required this.deviceWidth,required this.fieldDatas});

  @override
  _TitleArea createState() => _TitleArea();
}

class _TitleArea extends State<TitleArea> {
  final TextEditingController _textEditingControllerTitle = TextEditingController();
  final double _thisHeight = 70.0;
  static const Color _hintTextColor = Colors.red;
  static const double _thisTextFieldMargin = 5.0;
  final TextStyle fontData = TextStyle(fontSize: 24);
  
  void initState() {
    super.initState();
    // 初期化の処理をここに記述する
    final String defaultText = widget.fieldDatas.title.toString();
    _textEditingControllerTitle.text = defaultText;
  }
    

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.deviceWidth,
      //height: _thisHeight, //高さ指定いらないかも
      child: Container(
        child:Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal:_thisTextFieldMargin), //ウィジェットの外側の余白
              child:TextField(
                controller: _textEditingControllerTitle,
                decoration: const InputDecoration(
                  hintText: 'タイトル(hintText)', //ヒントテキスト
                  hintStyle: TextStyle(
                    color: _hintTextColor,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: fontData,
                onChanged: (value) {
                  // テキストが変更されたときの処理
                  widget.fieldDatas.title = _textEditingControllerTitle.text;
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
import 'package:flutter/material.dart';
import '/widget/create_horizontal_line.dart';

class TitleArea extends StatefulWidget {
  final double deviceWidth;
  final TextEditingController textEditingControllerTitle;

  TitleArea({required this.deviceWidth,required this.textEditingControllerTitle});

  @override
  _TitleArea createState() => _TitleArea();
}

class _TitleArea extends State<TitleArea> {
    final double _thisHeight = 70.0;
    static const Color _hintTextColor = Colors.red;
    static const double _thisTextFieldMargin = 5.0;

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
                controller: widget.textEditingControllerTitle,
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
                  print('Input: $value');
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
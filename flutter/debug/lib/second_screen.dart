import 'package:flutter/material.dart';
import 'screen_transition.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}
// デバッグ用の仮画面クラス
class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            bool canGoBack =
                    ScreenTransition.canPop(context, '/'); // ここでは遷移元を'/'と仮定

            if (canGoBack) {
              Navigator.pop(context); // 遷移元の画面に戻る
            }
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}

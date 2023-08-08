import 'package:flutter/material.dart';
import 'dart:io';
import 'utils/database_helper.dart';
import 'change_binaly_data.dart';
import 'register_text.dart';

//Directory documentsDirectory = await getApplicationDocumentsDirectory();
//ChromeProxyService: Failed to evaluate expression 'documentsDirectory': InternalError: Expression evaluation in async frames is not supported. No frame with index 45..

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterText(),
    );
  }
}

class ChatScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          RegisterText(),
          ElevatedButton(
            onPressed: () async {
              // 画像ファイルがあると仮定
              File imageFile = File('/画像へのパス/image.png');

              // ChangeBinalyDataクラスのメソッドを呼び出して画像をデータベースに登録
              await ChangeBinalyData.registerImage(imageFile);
            },
            child: Text('画像を登録'),
          ),
        ],
      ),
    );
  }
}

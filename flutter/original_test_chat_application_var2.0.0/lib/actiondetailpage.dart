import 'package:flutter/material.dart';
import 'actioneditpage.dart';

class ActionDetailPage extends StatelessWidget {
  final Map<String, dynamic>? action_table_alldata_detailpage;
  //選択されているレコードの全てのデータを引数としてもらう
  const ActionDetailPage({required this.action_table_alldata_detailpage});

  final double field1FontSize= 30.0;
  final double field2FontSize= 16.0;
  final double field3FontSize= 16.0;
  final double field4FontSize= 16.0;
  final double field5FontSize= 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('アクション詳細'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // アクション詳細設定の処理
              _MoveActionEditPageProcess(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'title:' + _getColumnData('action_name'),//nullチェックをしてから画面にテキストを表示
                  softWrap: false,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: field1FontSize),
                ),
              ),
            ),
            _drawHorizontalLine(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'タグ',
                  softWrap: false,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: field2FontSize),
                ),
              ),
            ),
            _drawHorizontalLine(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'start:' + _getColumnData('action_start'),
                  softWrap: false,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: field3FontSize),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'end:' + _getColumnData('action_end'),
                  softWrap: false,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: field4FontSize),
                ),
              ),
            ),
            _drawHorizontalLine(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'score:' + _getColumnData('action_score'),
                  softWrap: false,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: field5FontSize),
                ),
              ),
            ),
            _drawHorizontalLine(),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _getColumnData('action_notes'),
                  softWrap: false,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: field5FontSize),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _drawHorizontalLine() {
    return Divider(
      color: Colors.black, // 線の色を指定 (省略可能)
      height: 1.0, // 線の高さを指定 (省略可能)
      thickness: 1.5, // 線の太さを指定 (省略可能)
      indent: 0.0, // 線の開始位置からのオフセットを指定 (省略可能)
      endIndent: 0.0, // 線の終了位置からのオフセットを指定 (省略可能)
    );
  }

  String _getColumnData(column_key){
    if (action_table_alldata_detailpage?[column_key] != null) {
      return action_table_alldata_detailpage?[column_key].toString() ?? "エラーが発生しました。";
    }
    return 'データがありません';
  }

  void _MoveActionEditPageProcess(BuildContext context){
    //Navigator.push(
    //  context,
    //  MaterialPageRoute(builder: (context) => ActionEditPage(action_table_alldata_editpage:action_table_alldata_detailpage)),
    //);

    Navigator.pushNamed(
      context,
      '/actionEditPage',
      arguments:{'choice_record':action_table_alldata_detailpage}//main.dartのonGenerateRouteに引数として渡す,型はMap<String, dynamic>
    );
  }
}

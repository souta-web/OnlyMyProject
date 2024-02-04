import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

//定義
class PieChartDataModel {
  final String label; //ラベル
  final double value; //％
  final Color color; //色

  //受取引数
  PieChartDataModel(this.label, this.value, this.color);
}

//DynamicPieChartクラス
//円グラフを表示し、データをダイナミックに更新できるウィジェット
class DynamicPieChart extends StatefulWidget {
  @override
  _DynamicPieChartState createState() => _DynamicPieChartState();
}

//_DynamicPieChartStateクラス
//DynamicPieChartウィジェットの状態を管理
class _DynamicPieChartState extends State<DynamicPieChart> {
  //円グラフにタッチされた時のインデックスを追跡する変数
  int touchedIndex = -1;
  //円グラフのデータを保持するリスト
  List<PieChartDataModel> pieChartData = [];

  @override
  void initState() {
    super.initState();
    // 初期データを設定
    pieChartData = generatePieChartData();
  }

  //ダミーデータ生成
  List<PieChartDataModel> generatePieChartData() {
    return [
      PieChartDataModel('食事', 10, Color.fromARGB(255, 231, 230, 230)),
      PieChartDataModel('勉強', 15, Color.fromARGB(255, 148, 255, 151)),
      PieChartDataModel('生活', 20, Color.fromARGB(255, 255, 161, 77)),
      PieChartDataModel('遊び', 25, Color.fromARGB(255, 253, 184, 184)),
      PieChartDataModel('睡眠', 30, Color.fromARGB(255, 11, 254, 253)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AspectRatio(
          //アスペクト比：表示物の幅と高さの比率(幅÷高さ)
          aspectRatio: 1.3, //1.3のアスペクト比を設定
          child: AspectRatio(
            aspectRatio: 1, // アスペクト比を1に設定
            child: PieChart(
              PieChartData(
                //円グラフのタッチ関連の設定
                pieTouchData: PieTouchData(
                  // タッチイベントを処理するコールバック関数
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      // イベントが対象となっていないか、またはタッチレスポンスが存在しないか、
                      // タッチしたセクションが存在しない場合
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        // タッチしたセクションが存在しないことを示すためにtouchedIndexを-1に設定
                        touchedIndex = -1;
                        return;
                      }
                      //タッチしたセクションのインデックスをtouchedIndexに設定
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(show: false), //グラフの境界線データ非表示
                sectionsSpace: 0,
                centerSpaceRadius: 0, //中央スペースの半径０
                sections: showingSections(), //セクションデータ生成
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: updateData,
          child: Text('Update Data'),
        ),
      ],
    );
  }

  // 円グラフ内のセクションのデータを生成
  List<PieChartSectionData> showingSections() {
    return pieChartData.asMap().entries.map((entry) {
      final int i = entry.key; //マップ内のインデックス
      final PieChartDataModel data = entry.value; //PieChartDataModelオブジェクト

      final isTouched = i == touchedIndex; //タッチさせてるかどうかに王子てスタイル調整
      final fontSize = isTouched ? 20.0 : 16.0; //タッチされるか否かでフォントサイズ変更
      final radius = isTouched ? 110.0 : 100.0; //タッチされるか否かでセクションの半径設定
      const shadows = [
        Shadow(color: Colors.black, blurRadius: 2)
      ]; //セクションの影のスタイルを設定

      return PieChartSectionData(
        color: data.color,
        value: data.value,
        title: '${data.label} ${data.value.toStringAsFixed(1)}%', //セクションのタイトル
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: shadows,
        ),
      );
    }).toList(); // エントリのリストを新しいリストに変換して返す
  }

  void updateData() {
    setState(() {
      // 新しいデータを取得してデータモデルのリストを更新
      pieChartData = generatePieChartData(); // 新しいデータを取得するメソッドを実装
      touchedIndex = -1; // タッチしたセクションをリセット
    });
  }
}
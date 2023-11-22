import 'package:flutter/material.dart';
//import 'package:nosato_chat_page_work/screen/data/line_chart_widget.dart';
//import 'package:nosato_chat_page_work/screen/data/pi_chart_widget.dart';
//import 'package:nosato_chat_page_work/screen/data/donuts_chart_widget.dart';
//import 'package:nosato_chat_page_work/screen/data/ddonut_chart_widget.dart';
import 'package:nosato_chat_page_work/screen/data/width_chart_widget.dart';

class DataScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/config');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 他のデータ表示ウィジェット
          //各グラフを表示
          //LineChartWidget(), //折れ線グラフ
          //DynamicPieChart(), //円フラフ
          //DonutChartSample(), //ドーナツ状の円グラフ
          //DDonutChartSample(), //ドーナツ状の時刻グラフ
          HorizontalBarChart(), //横棒
        ],
      ),
    );
  }
}

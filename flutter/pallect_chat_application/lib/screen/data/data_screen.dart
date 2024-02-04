import 'package:flutter/material.dart';
//import 'package:nosato_chat_page_work/screen/data/line_chart_widget.dart';
import '/screen/data/pi_chart_widget.dart';
//import 'package:nosato_chat_page_work/screen/data/donuts_chart_widget.dart';
//import 'package:nosato_chat_page_work/screen/data/ddonut_chart_widget.dart';
import '/screen/data/width_chart_widget.dart';
//import 'package:nosato_chat_page_work/screen/data/2width_chart_widget.dart';

class DataScreenWidget extends StatelessWidget {
  final List<BarChartData> mainTagData = [
    BarChartData('MainTag1', 120),
    BarChartData('MainTag2', 90),
  ];

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'pie',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            DynamicPieChart(), //円フラフ
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Actions:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // 他のデータ表示ウィジェット
            //各グラフを表示
            //LineChartWidget(), //折れ線グラフ
            //DynamicPieChart(), //円フラフ
            //DonutChartSample(), //ドーナツ状の円グラフ
            //DDonutChartSample(), //ドーナツ状の時刻グラフ
            HorizontalBarChart(data: mainTagData), //横棒
          ],
        ),
      ),
    );
  }
}

double dataHeight(BuildContext context) {
  return MediaQuery.of(context).size.height * 0.6;
}

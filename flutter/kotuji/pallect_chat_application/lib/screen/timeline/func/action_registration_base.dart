import 'package:flutter/material.dart';
//import '../widget/time_line_base.dart';

final List<List<Map<String, dynamic>>> y2023m09d18 = [
  [{"startTime": "0:00","endTime": "7:35","color": Colors.amber,"title": "睡眠計測する"}],
  [{"startTime": "7:10","endTime": "7:25","color": Colors.amber,"title": "朝食食べる"}],
  [{"startTime": "7:25","endTime": "8:30","color": Colors.amber,"title": "バイトに行く"}],
];

final List<List<Map<String, dynamic>>> y2023m09d19 = [
  [{"startTime": "0:00","endTime": "7:35","color": Colors.red,"title": "ポケモンスリープする"}],
  [{"startTime": "7:10","endTime": "7:25","color": Colors.red,"title": "朝ごはん食べる"}],
  [{"startTime": "7:25","endTime": "8:30","color": Colors.red,"title": "登校する"}],
];

final List<List<Map<String, dynamic>>> y2023m09d20 = [
  [{"startTime": "0:00","endTime": "7:35","color": Colors.amber,"title": "睡眠計測しない"}],
  [{"startTime": "7:10","endTime": "7:25","color": Colors.amber,"title": "朝食食べる"}],
  [{"startTime": "7:25","endTime": "8:30","color": Colors.amber,"title": "バイトに行く"}],
];

final List<List<Map<String, dynamic>>> y2023m09d21 = [
  [{"startTime": "0:00","endTime": "7:35","color": Colors.red,"title": "ポケモンスリープしない"}],
  [{"startTime": "7:10","endTime": "7:25","color": Colors.red,"title": "朝ごはん食べる"}],
  [{"startTime": "7:25","endTime": "8:30","color": Colors.red,"title": "登校する"}],
];

final Map<String, List<List<Map<String, dynamic>>>> schedulesByDate = {
  'y2023m10d18': y2023m09d18,
  'y2023m10d19': y2023m09d19,
  'y2023m10d20': y2023m09d20,
  'y2023m10d21': y2023m09d21,
};

List<List<Map<String, dynamic>>> newDatas = [];

List<Map<String, dynamic>> changeFormat(List<List<Map<String, dynamic>>> inputList) {
  List<Map<String, dynamic>> outputList = [];
  for (var subList in inputList) {
    outputList.addAll(subList);
  }
  return outputList;
}

List<Map<String, dynamic>> setData(String formattedDate) {
  List<Map<String, dynamic>> convertedData = []; // 変数を初期化
  
  if (schedulesByDate.containsKey(formattedDate)) {
    newDatas = schedulesByDate[formattedDate]!;
    //print(newDatas);//成型前のデータ
    convertedData = changeFormat(newDatas);
    //print(convertedData);
  }
  //print(convertedData);
  return convertedData;

}

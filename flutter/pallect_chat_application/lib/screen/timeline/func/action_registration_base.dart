import 'package:flutter/material.dart';

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

final Map<String, List<List<Map<String, dynamic>>>> schedulesByDate = {
  'y2023m09d18': y2023m09d18,
  'y2023m09d19': y2023m09d19,
};

List<List<Map<String, dynamic>>> newDatas = [];



List<Map<String, dynamic>> changeFormat(List<List<Map<String, dynamic>>> inputList) {
  List<Map<String, dynamic>> outputList = [];
  for (var subList in inputList) {
    outputList.addAll(subList);
  }
  return outputList;
}

void setData(String formattedDate) {
  if (schedulesByDate.containsKey(formattedDate)) {
    newDatas = schedulesByDate[formattedDate]!;
    print(newDatas);
    List<Map<String, dynamic>> convertedData = changeFormat(newDatas);
    print(convertedData);
    //upDateData(convertedData);
  }
}

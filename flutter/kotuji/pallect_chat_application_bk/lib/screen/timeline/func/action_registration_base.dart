import 'package:flutter/material.dart';

class TimeLineActionsData {
  static final TimeLineActionsData _instance = TimeLineActionsData._internal();

  factory TimeLineActionsData() {
    return _instance;
  }

  TimeLineActionsData._internal();

  late List<Map<String, dynamic>> defaultData = [
    {"startTime": "0:00", "endTime": "1:45", "color": Colors.amber, "title": "default"}
  ];

  void updateDefaultData(List<Map<String, dynamic>> nextData) {
    print("defaultData1");
    print(defaultData);//変更前の値を保持
    defaultData = nextData;  // クラスレベルのdefaultDataを更新
    print("defaultData2");
    print(defaultData);
  }
}

  final List<List<Map<String, dynamic>>> y2023m10d18 = [
    [{"startTime": "0:00", "endTime": "7:35", "color": Colors.blue, "title": "睡眠計測する"}],
    [{"startTime": "7:10", "endTime": "7:25", "color": Colors.blue, "title": "朝食食べる"}],
    [{"startTime": "7:25", "endTime": "8:30", "color": Colors.blue, "title": "バイトに行く"}],
  ];

  final List<List<Map<String, dynamic>>> y2023m10d19 = [
    [{"startTime": "0:00", "endTime": "7:35", "color": Colors.red, "title": "ポケモンスリープする"}],
    [{"startTime": "7:10", "endTime": "7:25", "color": Colors.red, "title": "朝ごはん食べる"}],
    [{"startTime": "7:25", "endTime": "8:30", "color": Colors.red, "title": "登校する"}],
  ];

  final List<List<Map<String, dynamic>>> y2023m10d20 = [
    [{"startTime": "0:00", "endTime": "7:35", "color": Colors.amber, "title": "睡眠計測しない"}],
    [{"startTime": "7:10", "endTime": "7:25", "color": Colors.amber, "title": "朝食食べる"}],
    [{"startTime": "7:25", "endTime": "8:30", "color": Colors.amber, "title": "バイトに行く"}],
  ];

  final List<List<Map<String, dynamic>>> y2023m10d21 = [
    [{"startTime": "0:00", "endTime": "7:35", "color": Colors.purple, "title": "ポケモンスリープしない"}],
    [{"startTime": "7:10", "endTime": "7:25", "color": Colors.purple, "title": "朝ごはん食べる"}],
    [{"startTime": "7:25", "endTime": "8:30", "color": Colors.purple, "title": "登校する"}],
  ];

  final Map<String, List<List<Map<String, dynamic>>>> schedulesByDate = {
    'y2023m10d18':y2023m10d18,
    'y2023m10d19':y2023m10d19,
    'y2023m10d20':y2023m10d20,
    'y2023m10d21':y2023m10d21,
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
    List<Map<String, dynamic>> convertedData = [];
    if (schedulesByDate.containsKey(formattedDate)) {
      newDatas = schedulesByDate[formattedDate]!;
      convertedData = changeFormat(newDatas);
    }
    return convertedData;
  }

class PreUpdateDefaultData{//updateDefaultDataを外部から使えるようにする

  void publicUpdateDefaultData(data) {
    final privateInstance = TimeLineActionsData();
    //data=[{"startTime": "0:00","endTime": "1:45" ,"color": Colors.amber,"title": "default2"},];

      privateInstance.updateDefaultData(data);
      print("Public!!");
      print(data);
  }
}

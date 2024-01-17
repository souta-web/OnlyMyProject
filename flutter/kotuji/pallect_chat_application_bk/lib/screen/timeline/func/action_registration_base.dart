import 'package:flutter/material.dart';

class TimeLineActionsData extends ChangeNotifier {

  @override
  void dispose() {
    TimeLineActionsData().dispose();
    super.dispose();
  }

  static final TimeLineActionsData _instance = TimeLineActionsData._internal();

  factory TimeLineActionsData() {
    return _instance;
  }

  TimeLineActionsData._internal();

  late List<Map<String, dynamic>> defaultData = [
    {"startTime": "0:00", "endTime": "1:45", "color": Colors.amber, "title": "default"}
  ];

  void updateDefaultData(List<Map<String, dynamic>> nextData) {
    defaultData = nextData;  // クラスレベルのdefaultDataを更新
    notifyListeners();
  }
}

  final List<List<Map<String, dynamic>>> y2023m12d01 = [
    [{"startTime": "0:00", "endTime": "7:35", "color": Colors.pink, "title": "睡眠"}],
    [{"startTime": "0:00", "endTime": "7:35", "color": Colors.green, "title": "睡眠計測"}],
    [{"startTime": "7:10", "endTime": "7:25", "color": Colors.red, "title": "朝食"}],
    [{"startTime": "7:25", "endTime": "8:30", "color": Colors.red, "title": "通学"}],
    [{"startTime": "9:00", "endTime": "12:30", "color": Colors.blue, "title": "午前授業"}],
    [{"startTime": "13:00", "endTime": "13:20", "color": Colors.amber, "title": "昼食"}],
    [{"startTime": "13:30", "endTime": "16:40", "color": Colors.blue, "title": "午後授業"}],
    [{"startTime": "17:00", "endTime": "18:30", "color": Colors.red, "title": "帰宅"}],
    [{"startTime": "19:00", "endTime": "19:30", "color": Colors.amber, "title": "夕飯"}],
    [{"startTime": "23:00", "endTime": "24:00", "color": Colors.green, "title": "睡眠計測"}],
  ];

  final List<List<Map<String, dynamic>>> y2023m12d02 = [
    [{"startTime": "0:00", "endTime": "7:35", "color": Colors.green, "title": "睡眠計測"}],
    [{"startTime": "7:10", "endTime": "7:25", "color": Colors.amber, "title": "朝食"}],
    [{"startTime": "7:25", "endTime": "8:30", "color": Colors.red, "title": "通学"}],
    [{"startTime": "9:00", "endTime": "12:30", "color": Colors.blue, "title": "午前授業"}],
    [{"startTime": "13:00", "endTime": "13:20", "color": Colors.amber, "title": "昼食"}],
    [{"startTime": "20:00", "endTime": "20:30", "color": Colors.amber, "title": "夕飯"}],
  ];

  final List<List<Map<String, dynamic>>> y2023m12d03 = [
    [{"startTime": "2:30", "endTime": "9:00", "color": Colors.green, "title": "睡眠計測"}],
    [{"startTime": "9:00", "endTime": "10:00", "color": Colors.amber, "title": "朝食"}],
    [{"startTime": "13:00", "endTime": "13:20", "color": Colors.amber, "title": "昼食"}],
    [{"startTime": "19:00", "endTime": "19:30", "color": Colors.amber, "title": "夕飯"}],
    [{"startTime": "23:00", "endTime": "24:00", "color": Colors.green, "title": "睡眠計測"}],
  ];

  final List<List<Map<String, dynamic>>> y2023m12d04 = [
    [{"startTime": "0:00", "endTime": "7:35", "color": Colors.green, "title": "睡眠計測"}],
    [{"startTime": "7:10", "endTime": "7:25", "color": Colors.amber, "title": "朝食"}],
    [{"startTime": "12:00", "endTime": "12:20", "color": Colors.amber, "title": "昼食"}],
    [{"startTime": "12:25", "endTime": "13:30", "color": Colors.red, "title": "通学"}],
    [{"startTime": "13:30", "endTime": "16:40", "color": Colors.blue, "title": "午後授業"}],
    [{"startTime": "17:00", "endTime": "18:30", "color": Colors.red, "title": "帰宅"}],
    [{"startTime": "19:00", "endTime": "19:30", "color": Colors.amber, "title": "夕飯"}],
    [{"startTime": "23:00", "endTime": "24:00", "color": Colors.green, "title": "睡眠計測"}],
  ];

  final Map<String, List<List<Map<String, dynamic>>>> schedulesByDate = {
    'y2023m12d01':y2023m12d01,
    'y2023m12d02':y2023m12d02,
    'y2023m12d03':y2023m12d03,
    'y2023m12d04':y2023m12d04,
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
  }
}

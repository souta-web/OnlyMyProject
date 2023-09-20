

class TimeLineDataManager {
  List<Map<String, dynamic>> actionsDatas = [];

  void upDateData(List<Map<String, dynamic>> newData) {
    actionsDatas = newData;
  }
}
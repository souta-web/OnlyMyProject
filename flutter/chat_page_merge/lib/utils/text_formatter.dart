class TextFormatter{
  String returnHourMinute(String timeText) {
    //年月日　時分秒を整形する
    late List<String> dateList;
    late List<String> timeList;
    late String hourMinute;

    dateList = (timeText.split(" "));
    timeList = dateList[1].split(":");
    hourMinute = timeList[0] + ":" + timeList[1];
    print(hourMinute);
    return hourMinute;
  }
}
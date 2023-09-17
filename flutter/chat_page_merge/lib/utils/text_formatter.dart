class TextFormatter {
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

  // 送信時間から共通idを作成する
  String returnChatActionLinkId(String timeText) {
    // 送信時間を数値化して数字以外の文字を取り除く
    final String numericTime = timeText.replaceAll(RegExp(r'[^0-9]'), '');
    return numericTime;
  }
}

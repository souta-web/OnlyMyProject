import 'dart:typed_data';

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

  // バイナリーデータ表示をわかりやすくする
  String returnImageBytes(List<Uint8List> imageBytes) {
    // 各バイトを16進数表現に変換
    List<String> hexList = imageBytes.expand((byteList) {
      return byteList.map((byte) => byte.toRadixString(16));
    }).toList();

    // 16進数の値をスペースで区切って結合
    String hexString = hexList.join(' ');

    print(hexString);
    return hexString;
  }
}

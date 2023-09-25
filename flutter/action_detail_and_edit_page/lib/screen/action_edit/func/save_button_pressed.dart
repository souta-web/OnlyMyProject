import 'package:logger/logger.dart';
//引数の値をデバッグ用のログとして出力
class SaveButtonPressed {
  void  dataOutPut( String title,
                    List<String> tagList,
                    String startTime,
                    String endTime,
                    int score,
                    String note
  ) {
    var logger = Logger();
    logger.d("title:$title");
    logger.d("tagList:$tagList");
    logger.d("startTime:$startTime");
    logger.d("endTime:$endTime");
    logger.d("score:$score");
    logger.d("note:$note");
  }
}
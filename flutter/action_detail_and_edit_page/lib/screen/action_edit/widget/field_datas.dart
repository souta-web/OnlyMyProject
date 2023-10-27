//編集ページで使う編集される値の宣言。
//これをインスタンス化して使うと、いろいろなクラスで共有して使える
class FieldDatas {
  late String title = "";
  late List<String> tags = [""];
  late String startTime= "";
  late String endTime= "";
  late int score= 1;
  late String note= "";
}
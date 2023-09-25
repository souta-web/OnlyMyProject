import '/screen/action_edit/widget/field_datas.dart';
class SetInitialData {
  final FieldDatas fieldDatas;

  SetInitialData(this.fieldDatas);

  void setData() {//ここで初期値を格納する
    fieldDatas.title = "default title";
    fieldDatas.tags = ["default tag"];
    fieldDatas.startTime= "default starttime";
    fieldDatas.endTime= "default endtime";
    fieldDatas.score= 0;
    fieldDatas.note= "default note";
  }
}
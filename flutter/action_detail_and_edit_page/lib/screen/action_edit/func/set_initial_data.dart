import '/screen/action_edit/widget/field_datas.dart';

//編集画面の編集可能エリアの初期化処理
class SetInitialData {
  final FieldDatas fieldDatas;

  SetInitialData(this.fieldDatas);

  void setData() {//ここで初期値を格納する
    fieldDatas.title = "default title";
    fieldDatas.tags = ["default tag"];
    fieldDatas.startTime= "2022-02-03 10:11:12.1231424132";
    fieldDatas.endTime= "2022-02-04 10:11:12.1231424132";
    fieldDatas.score= 0;
    fieldDatas.note= "default note";
  }
}
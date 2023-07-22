import 'dart:io';
import 'database_helper.dart';


// 画像データをデータベースに登録する
class ChangeBinalyData {
  // データベースに画像をバイナリデータとして登録するメソッド
  static Future<void> registerImage(File imageFile) async {
    try {
      // 画像ファイルが存在するかチェック
      if (imageFile.existsSync()) {
        // 画像データをバイトのリストとして読み込む
        List<int> imageBytes = await imageFile.readAsBytes();

        // 画像データを含む行を表すマップを作成
        Map<String, dynamic> row = {
          'action_name': '画像アクション',
          'action_media': imageBytes,
        };

        // DatabaseHelperのインスタンスを取得
        final DatabaseHelper dbHelper = DatabaseHelper.instance;

        // 画像データをaction_tableに登録
        int id = await dbHelper.insert_action_table(row);

        if (id > 0) {
          print('データがID: $id として登録されました');
        } else {
          print('データの登録に失敗しました。');
        }
      } else {
        print('画像ファイルが存在しません。');
      }
    } catch (e) {
      print('画像の登録中にエラーが発生しました: $e');
    }
  }
}

// 使用例
void main() async {
  // 画像ファイルがあると仮定します
  File imageFile = File('/画像へのパス/image.png');

  // registerImageメソッドを呼び出して画像をデータベースに登録します
  await ChangeBinalyData.registerImage(imageFile);
}

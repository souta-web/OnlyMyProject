import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'database_helper.dart';

class SearchDatabase {
  Future<void> search(String keyword) async {
    // データベースヘルパーのインスタンスを生成
    DatabaseHelper dbHelper = DatabaseHelper.instance;

    // データベースからチャットテーブルの一致するレコードを検索
    List<Map<String, dynamic>> chatRecords =
        await dbHelper.queryAllRows_chat_table();
    List<Map<String, dynamic>> matchedChatRecords = chatRecords
        .where((record) =>
            record[DatabaseHelper.columnChatMessage]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnChatSender]
                .toString()
                .contains(keyword))
        .toList();

    // データベースからアクションテーブルの一致するレコードを検索
    List<Map<String, dynamic>> actionRecords =
        await dbHelper.queryAllRows_action_table();
    List<Map<String, dynamic>> matchedActionRecords = actionRecords
        .where((record) =>
            record[DatabaseHelper.columnActionName]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionMessage]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnActionNotes]
                .toString()
                .contains(keyword))
        .toList();

    // データベースからタグテーブルの一致するレコードを検索
    List<Map<String, dynamic>> tagRecords =
        await dbHelper.queryAllRows_tag_table();
    List<Map<String, dynamic>> matchedTagRecords = tagRecords
        .where((record) =>
            record[DatabaseHelper.columnTagName]
                .toString()
                .contains(keyword) ||
            record[DatabaseHelper.columnTagRegisteredActionName]
                .toString()
                .contains(keyword))
        .toList();

    // チャットテーブルの一致するレコードを出力
    print('Matched records in Chat_Table:');
    for (var record in matchedChatRecords) {
      print(record);
    }

    // アクションテーブルの一致するレコードを出力
    print('Matched records in Action_Table:');
    for (var record in matchedActionRecords) {
      print(record);
    }

    // タグテーブルの一致するレコードを出力
    print('Matched records in Tag_Table:');
    for (var record in matchedTagRecords) {
      print(record);
    }
  }
}

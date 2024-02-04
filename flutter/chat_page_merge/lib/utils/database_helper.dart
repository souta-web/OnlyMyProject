import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  // デバッグ時はDB名を変えてよい
  static final _databaseName = "PallectDatabase1.db"; // DB名
  static final _databaseVersion = 1; // スキーマのバージョン指定

  static final chat_table = 'chat_table'; // チャット管理テーブル
  static final action_table = 'action_table'; //アクション(Todo)管理テーブル
  static final tag_table = 'tag_table'; // タグ管理テーブル
  static final media_table = 'media_table'; // メディア保存テーブル
  static final tag_setting_table = 'tag_setting_table'; // タグ設定テーブル
  static final action_time_table = 'action_time_table'; // アクションタイムテーブル
  static final chat_time_table = 'chat_time_table'; // チャットタイムテーブル

  // カラム名とは項目名の事(辻)
  // チャットテーブルのカラム
  static final columnChatId = '_chat_id'; // カラム名：ID
  static final columnChatSender = 'chat_sender'; // 送信者情報(true=ユーザー:fasle=AI)
  static final columnChatTodo = 'chat_todo'; //todoかどうか(true=todo:false=message)
  static final columnChatMessage = 'chat_message'; // チャットのテキスト
  static final columnChatMessageId = 'chat_message_id'; // 送信先メッセージID

  // アクションテーブルのカラム
  static final columnActionId = '_action_id'; //ID
  static final columnActionTitle = 'action_title'; //アクションタイトル
  static final columnActionState = 'action_state'; // 進行状態
  static final columnActionNotes = 'action_notes'; //説明文
  static final columnActionScore = 'action_score'; //充実度(1から5までの値で制限する)
  static final columnStartChatId = 'start_chat_id'; // 開始チャットID

  // タグテーブルのカラム
  static final columnTagId = '_tag_id'; // タグID
  static final columnTagName = 'tag_name'; // タグ名
  static final columnTagColor = 'tag_color'; // タグの色
  static final columnTagIcon = 'tag_icon'; // アイコン

  // メディアテーブルのカラム
  static final columnMediaId = '_media_id'; // メディアID
  static final columnMedia = 'media'; // メディア
  static final columnMediaChatId = '_media_chat_id'; // 添付メッセージID
  static final columnLinkActionId = '_link_action_id'; // 関連アクションID

  // タグ設定テーブルのカラム
  static final columnTagActionId = '_tag_action_id'; // アクションID
  static final columnSetTagId = '_set_tag_id'; // タグID
  static final columnMainTagFlag = 'main_tag_flag'; // メインタグかどうか

  // アクションタイムテーブルのカラム
  static final columnActionTimeId = '_action_time_id'; // アクションタイムID
  static final columnSetActionId = '_set_action_id'; // アクションID
  static final columnActionJudgeTime = 'action_judge_time'; // 開始時刻か終了時刻か
  static final columnActionYear = 'action_year'; // 年
  static final columnActionMonth = 'action_month'; // 月
  static final columnActionDay = 'action_day'; // 日
  static final columnActionHours = 'action_hours'; // 時
  static final columnActionMinutes = 'action_minutes'; // 分
  static final columnActionSeconds = 'action_seconds'; // 秒
  static final columnLessActionSeconds = 'less_action_seconds'; // 秒未満

  // チャットタイムテーブルのカラム
  static final columnChatTimeId = '_chat_time_id'; // チャットタイムID
  static final columnSetChatId = '_set_chat_id'; // チャットID
  static final columnChatYear = 'chat_year'; // 年
  static final columnChatMonth = 'chat_month'; // 月
  static final columnChatDay = 'chat_day'; // 日
  static final columnChatHours = 'chat_hours'; // 時
  static final columnChatMinutes = 'chat_minutes'; // 分
  static final columnChatSeconds = 'chat_seconds'; // 秒
  static final columnLessChatSeconds = 'less_chat_seconds'; // 秒未満

  // DatabaseHelper クラスを定義
  DatabaseHelper._privateConstructor();
  // DatabaseHelper._privateConstructor() コンストラクタを使用して生成されたインスタンスを返すように定義
  // DatabaseHelper クラスのインスタンスは、常に同じものであるという保証
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Databaseクラス型のstatic変数_databaseを宣言
  // クラスはインスタンス化しない
  static Database? _database;

  // databaseメソッド定義
  // 非同期処理
  Future<Database?> get database async {
    // _databaseがNULLか判定
    // NULLの場合、_initDatabaseを呼び出しデータベースの初期化し、_databaseに返す
    // NULLでない場合、そのまま_database変数を返す
    // これにより、データベースを初期化する処理は、最初にデータベースを参照するときにのみ実行されるようになります。
    // このような実装を「遅延初期化 (lazy initialization)」と呼びます。
    if (_database != null) return _database;
    _database = await initDatabase();
    //カラムを追加したい時だけ次の行のコメントアウトを解除プラス関数の中身を書き換える
    //_addcolumn();
    return _database;
  }

  // データベース接続
  initDatabase() async {
    // アプリケーションのドキュメントディレクトリのパスを取得
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // 取得パスを基に、データベースのパスを生成
    String path = join(documentsDirectory.path, _databaseName);
    // データベース接続
    return await openDatabase(path,
        version: _databaseVersion,
        // テーブル作成メソッドの呼び出し
        onCreate: _onCreate, onConfigure: (db) {
      // 外部キーを有効にする
      db.execute('PRAGMA foreign_keys = true');
    });
  }

  _addcolumn() async {
    await _database?.execute('ALTER TABLE my_table ADD COLUMN time TEXT');
  }

  // テーブル作成
  // 引数:dbの名前
  // 引数:スキーマーのversion
  // スキーマーのバージョンはテーブル変更時にバージョンを上げる（テーブル・カラム追加・変更・削除など）
  Future _onCreate(Database db, int version) async {
    try {
      //それぞれのidの型を指定する必要がある($id 型)の形で指定
      //データベースを再生成するときは１行下のプログラム実行しないといけない
      //await db.execute('DROP TABLE IF EXISTS my_table');
      // チャットテーブルの作成
      await db.execute('''
      CREATE TABLE $chat_table (
        $columnChatId INTEGER PRIMARY KEY,
        $columnChatSender TEXT NOT NULL,
        $columnChatTodo TEXT NOT NULL,
        $columnChatMessage TEXT,
        $columnChatMessageId INTEGER
      )
    ''');

      // アクションテーブルの作成
      await db.execute('''
      CREATE TABLE $action_table (
        $columnActionId INTEGER PRIMARY KEY,
        $columnActionTitle TEXT,
        $columnActionState TEXT NOT NULL,
        $columnActionNotes TEXT,
        $columnActionScore INTEGER CHECK ($columnActionScore >= 1 AND $columnActionScore <= 5),
        $columnStartChatId INTEGER
      )
    ''');

      // タグテーブルの作成
      await db.execute('''
      CREATE TABLE $tag_table (
        $columnTagId INTEGER PRIMARY KEY,
        $columnTagName TEXT,
        $columnTagColor INTEGER,
        $columnTagIcon TEXT
      )
    ''');

      // メディアテーブルの作成
      await db.execute('''
      CREATE TABLE $media_table (
        $columnMediaId INTEGER PRIMARY KEY,
        $columnMedia BLOB NOT NULL,
        $columnMediaChatId INTEGER,
        $columnLinkActionId INTEGER,
        FOREIGN KEY ($columnMediaChatId) REFERENCES $chat_table($columnChatId),
        FOREIGN KEY ($columnLinkActionId) REFERENCES $action_table($columnActionId)
      )
    ''');

      // タグ設定テーブルの作成
      await db.execute('''
      CREATE TABLE $tag_setting_table (
        $columnTagActionId INTEGER,
        $columnSetTagId INTEGER,
        $columnMainTagFlag TEXT,
        PRIMARY KEY($columnTagActionId, $columnSetTagId),
        FOREIGN KEY ($columnTagActionId) REFERENCES $action_table($columnActionId),
        FOREIGN KEY ($columnSetTagId) REFERENCES $tag_table($columnTagId)
      )
  ''');

      // アクションタイムテーブルの作成
      await db.execute('''
      CREATE TABLE $action_time_table (
        $columnActionTimeId INTEGER PRIMARY KEY,
        $columnSetActionId INTEGER NOT NULL,
        $columnActionJudgeTime TEXT NOT NULL,
        $columnActionYear INTEGER NOT NULL,
        $columnActionMonth INTEGER NOT NULL,
        $columnActionDay INTEGER NOT NULL,
        $columnActionHours INTEGER NOT NULL,
        $columnActionMinutes INTEGER NOT NULL,
        $columnActionSeconds INTEGER NOT NULL,
        $columnLessActionSeconds REAL NOT NULL,
        FOREIGN KEY ($columnSetActionId) REFERENCES $action_table($columnActionId)
      )
  ''');

      // チャットタイムテーブルの作成
      await db.execute('''
      CREATE TABLE $chat_time_table (
        $columnChatTimeId INTEGER PRIMARY KEY,
        $columnSetChatId INTEGER NOT NULL,
        $columnChatYear INTEGER NOT NULL,
        $columnChatMonth INTEGER NOT NULL,
        $columnChatDay INTEGER NOT NULL,
        $columnChatHours INTEGER NOT NULL,
        $columnChatMinutes INTEGER NOT NULL,
        $columnChatSeconds INTEGER NOT NULL,
        $columnLessChatSeconds REAL NOT NULL,
        FOREIGN KEY ($columnSetChatId) REFERENCES $chat_table($columnChatId)
      )
  ''');
    } catch (e) {
      print('データベースクラス作成中にエラーが発生しました: $e');
    }
  }

  // チャット画面用の関数
  // 登録処理
  Future<int> insert_chat_table(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(chat_table, row);
  }

  // 照会処理
  Future<List<Map<String, dynamic>>> queryAllRows_chat_table() async {
    Database? db = await instance.database;
    return await db!.query(chat_table);
  }

  // レコード数を確認
  Future<int?> queryRowCount_chat_table() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $chat_table'));
  }

  //　更新処理
  Future<int> update_chat_table(Map<String, dynamic> row, int id) async {
    Database? db = await instance.database;
    int id = row[columnChatId];
    return await db!
        .update(chat_table, row, where: '$columnChatId = ?', whereArgs: [id]);
  }

  //　削除処理
  Future<int> delete_chat_table(int id) async {
    Database? db = await instance.database;
    return await db!
        .delete(chat_table, where: '$columnChatId = ?', whereArgs: [id]);
  }

  // アクションテーブル用の関数
  // 登録処理
  Future<int> insert_action_table(Map<String, dynamic> row) async {
    Database? db = await instance.database;

    return await db!.insert(action_table, row);
  }

  // 照会処理
  Future<List<Map<String, dynamic>>> queryAllRows_action_table() async {
    Database? db = await instance.database;
    return await db!.query(action_table);
  }

  // レコード数を確認
  Future<int?> queryRowCount_action_table() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $action_table'));
  }

  //　更新処理
  Future<int> update_action_table(Map<String, dynamic> row, int id) async {
    Database? db = await instance.database;
    return await db!.update(action_table, row,
        where: '$columnActionId = ?', whereArgs: [id]);
  }

  //　削除処理
  Future<int> delete_action_table(int id) async {
    Database? db = await instance.database;
    return await db!
        .delete(action_table, where: '$columnActionId = ?', whereArgs: [id]);
  }

  // タグテーブル用の関数
  // 登録処理
  Future<int> insert_tag_table(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(tag_table, row);
  }

  // 照会処理
  Future<List<Map<String, dynamic>>> queryAllRows_tag_table() async {
    Database? db = await instance.database;
    return await db!.query(tag_table);
  }

  // レコード数を確認
  Future<int?> queryRowCount_tag_table() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $tag_table'))!;
  }

  // 更新処理
  Future<int> update_tag_table(Map<String, dynamic> row, int _id) async {
    Database? db = await instance.database;
    int _id = row[columnTagId];
    return await db!
        .update(tag_table, row, where: '$columnTagId = ?', whereArgs: [_id]);
  }

  // 削除処理
  Future<int> delete_tag_table(int _id) async {
    Database? db = await instance.database;
    return await db!
        .delete(tag_table, where: '$columnTagId = ?', whereArgs: [_id]);
  }

  // メディアテーブル用の関数
  // 登録処理
  Future<int> insert_media_table(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(media_table, row);
  }

  // 照会処理
  Future<List<Map<String, dynamic>>> queryAllRows_media_table() async {
    Database? db = await instance.database;
    return await db!.query(media_table);
  }

  // レコード数を確認
  Future<int?> queryRowCount_media_table() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $media_table'));
  }

  //　更新処理
  Future<int> update_media_table(Map<String, dynamic> row, int id) async {
    Database? db = await instance.database;
    int id = row[columnMediaId];
    return await db!
        .update(media_table, row, where: '$columnMediaId = ?', whereArgs: [id]);
  }

  //　削除処理
  Future<int> delete_media_table(int id) async {
    Database? db = await instance.database;
    return await db!
        .delete(media_table, where: '$columnMediaId = ?', whereArgs: [id]);
  }

  // タグ設定テーブル用の関数
  // 登録処理
  Future<int> insert_tag_setting_table(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(tag_setting_table, row);
  }

  // 照会処理
  Future<List<Map<String, dynamic>>> queryAllRows_tag_setting_table() async {
    Database? db = await instance.database;
    return await db!.query(tag_setting_table);
  }

  // レコード数を確認
  Future<int?> queryRowCount_tag_setting_table() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $tag_setting_table'));
  }

  //　更新処理
  Future<int> update_tag_setting_table(Map<String, dynamic> row, int id) async {
    Database? db = await instance.database;
    int id = row[columnTagActionId];
    return await db!.update(tag_setting_table, row,
        where: '$columnTagActionId = ?', whereArgs: [id]);
  }

  //　削除処理
  Future<int> delete_tag_setting_table(int id) async {
    Database? db = await instance.database;
    return await db!.delete(tag_setting_table,
        where: '$columnTagActionId = ?', whereArgs: [id]);
  }

  // アクションタイムテーブル用の関数
  // 登録処理
  Future<int> insert_action_time_table(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(action_time_table, row);
  }

  // 照会処理
  Future<List<Map<String, dynamic>>> queryAllRows_action_time_table() async {
    Database? db = await instance.database;
    return await db!.query(action_time_table);
  }

  // レコード数を確認
  Future<int?> queryRowCount_action_time_table() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $action_time_table'));
  }

  //　更新処理
  Future<int> update_action_time_table(Map<String, dynamic> row, int id) async {
    Database? db = await instance.database;
    int id = row[columnActionTimeId];
    return await db!.update(action_time_table, row,
        where: '$columnActionTimeId = ?', whereArgs: [id]);
  }

  //　削除処理
  Future<int> delete_action_time_table(int id) async {
    Database? db = await instance.database;
    return await db!.delete(action_time_table,
        where: '$columnActionTimeId = ?', whereArgs: [id]);
  }

  // チャットタイムテーブル用の関数
  // 登録処理
  Future<int> insert_chat_time_table(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(chat_time_table, row);
  }

  // 照会処理
  Future<List<Map<String, dynamic>>> queryAllRows_chat_time_table() async {
    Database? db = await instance.database;
    return await db!.query(chat_time_table);
  }

  // レコード数を確認
  Future<int?> queryRowCount_chat_time_table() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $chat_time_table'));
  }

  //　更新処理
  Future<int> update_chat_time_table(Map<String, dynamic> row, int id) async {
    Database? db = await instance.database;
    if (row['$columnChatTimeId'] != null) {
      await db!.update(chat_time_table, row,
          where: '$columnChatTimeId = ?', whereArgs: [id]);
    }

    return await db!.update(chat_time_table, row,
        where: '$columnChatTimeId = ?', whereArgs: [id]);
  }

  //　削除処理
  Future<int> delete_chat_time_table(int id) async {
    Database? db = await instance.database;
    return await db!.delete(chat_time_table,
        where: '$columnChatTimeId = ?', whereArgs: [id]);
  }
}

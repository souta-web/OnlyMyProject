import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  // デバッグ時はDB名を変えてよい
  static final _databaseName = "MyDatabase30.db"; // DB名
  static final _databaseVersion = 1; // スキーマのバージョン指定

  static final chat_table = 'chat_table'; // チャット管理テーブル
  static final action_table = 'action_table'; //アクション(Todo)管理テーブル
  static final tag_table = 'tag_table'; // タグ管理テーブル

  // カラム名とは項目名の事(辻)
  // チャットテーブルのカラム
  static final columnChatId = '_chat_id'; // カラム名：ID
  static final columnChatSender = 'chat_sender'; // 送信者情報(true=ユーザー:fasle=AI)
  static final columnChatTodo = 'chat_todo'; //todoかどうか(true=todo:false=message)
  static final columnChatTodofinish = 'chat_todofinish';
  static final columnChatMessage = 'chat_message'; // チャットのテキスト
  static final columnChatTime = 'chat_time'; //送信時間
  static final columnChatChannel = 'chat_channel'; //チャットチャンネル
  static final columnChatActionId =
      'chat_action_id'; //このチャットと紐づけられているアクションのidがここに入る

  // アクションテーブルのカラム
  static final columnActionId = '_action_id'; //ID
  static final columnActionName = 'action_name'; //アクション名
  static final columnActionStart = 'action_start'; //開始時刻
  static final columnActionEnd = 'action_end'; //終了時刻
  static final columnActionDuration = 'action_duration'; //総時間
  static final columnActionMessage = 'action_message'; //開始メッセージ
  static final columnActionMedia = 'action_media'; //添付メディア
  static final columnActionNotes = 'action_notes'; //説明文
  static final columnActionScore = 'action_score'; //充実度(1から5までの値で制限する)
  static final columnActionState = 'action_state'; //状態(0=未完了,1=完了)
  static final columnActionPlace = 'action_place'; //場所
  static final columnActionMainTag = 'action_main_tag'; //メインタグ
  static final columnActionSubTag = 'action_sub_tag'; //サブタグ

  // タグテーブルのカラム
  static final columnTagId = 'tag_id'; // タグID
  static final columnTagName = 'tag_name'; // タグ名
  static final columnTagColor = 'tag_color'; // タグの色
  static final columnTagRegisteredActionName =
      'tag_registered_action_name'; // 登録されたアクション名

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
        onCreate: _onCreate);
  }

  _addcolumn() async {
    await _database?.execute('ALTER TABLE my_table ADD COLUMN time TEXT');
  }

  // テーブル作成
  // 引数:dbの名前
  // 引数:スキーマーのversion
  // スキーマーのバージョンはテーブル変更時にバージョンを上げる（テーブル・カラム追加・変更・削除など）
  Future _onCreate(Database db, int version) async {
    //それぞれのidの型を指定する必要がある($id 型)の形で指定
    //データベースを再生成するときは１行下のプログラム実行しないといけない
    //await db.execute('DROP TABLE IF EXISTS my_table');
    await db.execute('''
      CREATE TABLE $chat_table (
        $columnChatId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnChatSender TEXT,
        $columnChatTodo TEXT,
        $columnChatTodofinish INTEGER,
        $columnChatMessage TEXT,
        $columnChatTime TEXT,
        $columnChatChannel TEXT,
        $columnChatActionId INTEGER
      )
    ''');

    // アクションテーブルの作成
    await db.execute('''
      CREATE TABLE $action_table (
        $columnActionId INTEGER PRIMARY KEY,
        $columnActionName TEXT,
        $columnActionStart TEXT,
        $columnActionEnd TEXT,
        $columnActionDuration TEXT,
        $columnActionMessage TEXT,
        $columnActionMedia BLOB,
        $columnActionNotes TEXT,
        $columnActionScore INTEGER CHECK ($columnActionScore >= 1 AND $columnActionScore <= 5), 
        $columnActionState INTEGER CHECK ($columnActionState >= 0 AND $columnActionState <= 1),
        $columnActionPlace TEXT,
        $columnActionMainTag TEXT,
        $columnActionSubTag TEXT,
        $columnChatActionId INTEGER DEFAULT $columnActionId
      )
    ''');

    // タグテーブルの作成
    await db.execute('''
      CREATE TABLE $tag_table (
        $columnTagId INTEGER PRIMARY KEY,
        $columnTagName TEXT ,
        $columnTagColor TEXT,
        $columnTagRegisteredActionName TEXT
      )
    ''');
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
}

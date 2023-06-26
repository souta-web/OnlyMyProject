import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static final _databaseName = "MyDatabase11.db"; // DB名
  static final _databaseVersion = 1; // スキーマのバージョン指定

  static final table = 'my_table'; // テーブル名

  //カラム名とは項目名の事(辻)
  static final columnId = '_id'; // カラム名：ID
  static final columnSender = 'sender'; // 送信者情報(true=ユーザー:fasle=AI)
  static final columnTodo = 'todo'; //todoかどうか(true=todo:false=message)
  static final columnTodofinish = 'todofinish'; //todoが完了済みかどうか(true=完了:false=終了)
  static final columnMessage = 'message'; // チャットのテキスト
  static final columnTime = 'time'; //送信時間

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
    _database = await _initDatabase();
    //カラムを追加したい時だけ次の行のコメントアウトを解除プラス関数の中身を書き換える
    //_addcolumn(); 
    return _database;
  }

  // データベース接続
  _initDatabase() async {
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
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnSender TEXT,
            $columnTodo TEXT,
            $columnTodofinish INTEGER, 
            $columnMessage TEXT,
            $columnTime TEXT
          )
          ''');
  }

  // 登録処理
  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  // 照会処理
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  // レコード数を確認
   Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  //　更新処理
   Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  //　削除処理
   Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
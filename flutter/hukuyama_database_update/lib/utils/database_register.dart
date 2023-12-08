import '/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

Future <void> query_insert() async {
final dbHelper = DatabaseHelper.instance;
Database? db = await dbHelper.database;

List<Map> result1 = await db!.rawQuery
//ここのクエリを変える
('SELECT * FROM tag_table WHERE tag_name = "遊び"');
print(result1);
}



//クエリ例

//SELECT
//SELECT * FROM tag_table

//WHERE
//OR
//SELECT tag_name FROM tag_table WHERE tag_name = "ゲーム" OR tag_name = "睡眠"
//AND
//SELECT tag_name FROM tag_table WHERE tag_name = "ゲーム" AND tag_name = "睡眠"
//NOT
//SELECT tag_name FROM tag_table WHERE NOT tag_name = "料理"
//IS NULL
//SELECT tag_name FROM tag_table WHERE tag_name = "料理" IS NULL
//LIKE
//SELECT tag_name FROM tag_table WHERE tag_name LIKE "%睡眠%"
//SELECT tag_name FROM tag_table WHERE tag_name LIKE "睡_"

//ORDER BY
//SELECT _tag_id FROM tag_table ORDER BY _tag_id ASC/DESC

//JOIN
//SELECT _tag_id FROM tag_table LEFT JOIN action_table ON tag_table._tag_id = action_table._action_id

//AS
//SELECT tag_name AS "タグ名" FROM tag_table WHERE tag_name="睡眠"

//COUNT
//SELECT COUNT(_tag_id) FROM tag_table
//MAX/MIN
//SELECT MAX/MIN(_tag_id) FROM tag_table
//AVG
//SELECT AVG(_tag_id) FROM tag_table
//SUM
//SELECT SUM(_tag_id) FROM tag_table

//GROUP BY
//SELECT tag_name, SUM(tag_color) FROM tag_table WHERE tag_name = 1 OR tag_name = 2 GROUP BY tag_name

//HAVING
//SELECT _tag_id FROM tag_table GROUP BY _tag_id HAVING _tag_id % 2 = 0

//サブクエリ使用
//SELECT * FROM (SELECT * FROM tag_table LEFT JOIN action_table ON tag_table._tag_id = action_table._action_id) AS A GROUP BY _tag_id HAVING _tag_id % 2 = 0

//DELETE
//DELETE FROM tag_table

//INSERT
//INSERT INTO tag_table (tag_name, tag_color, tag_registered_action_name) VALUES ("遊び", "orange", "映画")
//INSERT INTO chat_table (chat_sender, chat_todo, chat_todofinish, chat_message, chat_time, chat_channel, chat_action_id)
//VALUES ("true", "false", "2023-11-29 21:00", "Hello", "2023-11-29 18:00", "channel", "11")
//INSERT INTO action_table (action_name, action_start, action_end, action_duration, action_message, action_media, action_notes, action_score, action_state, action_place, action_main_tag, action_sub_tag, action_chat_id)
//VALUES ("夜ご飯", "2023-11-29 17:00", "2023-11-29 18:00", "1h", "start", "rice", "今日の夜ご飯", "4", "true", "家", "ご飯", "なし", "2")

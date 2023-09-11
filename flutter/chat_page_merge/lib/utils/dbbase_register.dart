import '/screen/chat/chat_screen.dart';
import '/utils/register_chat_table.dart';
import '/utils/register_action_table.dart';

class SendButtonPressed{
  sendButtonPressed(){ //送信ボタンが押されたときに呼び出される
    RegisterChatTable(); //ここは確定で呼び出す
    if (_isTodo) { //トグルボタンがオンの時だけ呼び出す
        RegisterActionTable();
    }
  }
}
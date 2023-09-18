import '/screen/chat/chat_screen.dart';
import '/utils/register_chat_table.dart';
import '/utils/register_action_table.dart';
import '/widget/chat_fukidashi.dart';
import '/widget/chat_todo.dart';


bool _isTodo = false;

drawChatObjects(){
  if (_isTodo) {
    ChatMessage(
      text: 'OK',
      isSentByUser: false
    );
  } else {
    ChatTodo(
      title: '行動開始',
      isSentByUser: false,
      mainTag: '生活',
      startTime: DateTime.now().toString(),
      actionFinished: false
      );
  }
}

sendButtonPressed(){ //送信ボタンが押されたときに呼び出される
  RegisterChatTable(
    chatSender: 'John',
    chatTodo: _isTodo ? 'todo' : 'meseeage',
    chatTodofinish: 12,
    chatMessage: 'Hello!',
    chatTime: DateTime.now().toString()
  ).registerChatTableFunc(); //ここは確定で呼び出す
  if (_isTodo) { //トグルボタンがオンの時だけ呼び出す
    RegisterActionTable(
      actionName: 'Emily',
      actionStart: DateTime.now().toString() 
    ).registerActionTableFunc();
  }
  return drawChatObjects();
}

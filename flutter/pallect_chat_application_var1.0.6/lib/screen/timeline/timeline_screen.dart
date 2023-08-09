import 'package:flutter/material.dart';

//final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);//system本体の初期設定に従う　あとからデータベースに保存した最後のデータになる？

class TimelineScreenWidget extends StatefulWidget {
  @override
  _TimelineScreenWidgetState createState() => _TimelineScreenWidgetState();
  
}

class _TimelineScreenWidgetState extends State<TimelineScreenWidget> {
  bool showButtons = false;
  int selectedNumber = 1;//デフォルト月です、あとから表示されたタイミングの時刻で変数作ります
  //final themeMode = ref.watch(themeModeProvider.state);//アプリのモードを切り替えに関わる変数
  
  
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('タイムライン'),
        //backgroundColor:ThemeMode==ThemeMode ? Colors.white:Colors.black,// AppBarの背景色を白に設定 //ThemeModeではなくthemeMode.stateにしたいんだけどなー
        //foregroundColor:ThemeMode==ThemeMode ? Colors.black:Colors.white, // 文字の背景色を白に設定
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/config');
              ///print(ThemeMode);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Stack(//要素を重ねる　あとのものが上にくる
              alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              print('Search button pressed!');
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              print('Add button pressed!');
                            },
                          ),
                        ],
                      ),
                      //SizedBox(height: 10.0),
                      // 0時から23時までの時間を表示する部分
                      for (var i = 0; i < 24; i++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                '$i:00', // 時刻を表示します
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10.0),
                              color: Color.fromARGB(255, 104, 104, 104),
                              width: 300.0,
                              height: 2.0,
                            ),
                            SizedBox(height: 40.0),
                            SizedBox(width: 30.0),
                          ],
                        ),
                        // 0時から23時までの時間を表示する部分

                      // 0時を表示する部分
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              '0:00', // 0時を表示します
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            color: Color.fromARGB(255, 104, 104, 104),
                            width: 300.0,
                            height: 2.0,
                          ),
                          SizedBox(height: 40.0),
                          SizedBox(width: 30.0),
                        ],
                      ),
                    // 0時を表示する部分
                    ],
                  ),
                  // ボタンを表示するか単一のボタンを表示するかの条件に基づいて、適切なウィジェットを返します
                  
                  showButtons ? buildGridButtons() : buildSingleButton(),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ボタンを表示するためのウィジェット
  Widget buildSingleButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        //padding: EdgeInsets.all(1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Color.fromARGB(255, 255, 81, 0)),
        ),
        backgroundColor: Colors.white, // ボタンの背景色を白に変更
        foregroundColor: Colors.black, // ボタンの文字の色を黒に変更
      ),
      child: Text('$selectedNumber月'), // 選択された月を表示します
      onPressed: () {
        setState(() {
          showButtons = true;
        });
      },
    );
  }

  // グリッド形式のボタンを表示するためのウィジェット
  Widget buildGridButtons() {

    // アスペクト比を計算する
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.width / 3;
    final double itemWidth = size.width / 2;

    return GridView.count(
      childAspectRatio: (itemWidth / itemHeight), //←比を計算していれる。
      shrinkWrap: true,
      crossAxisCount: 3,
      children: List.generate(12, (index) {//1-12月のボタンをつくる
        final number = index + 1;
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            //padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20), // 縦方向のパディングと横方向のパディングを設定します
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Color.fromARGB(255, 255, 81, 0)),
            ),
            backgroundColor: Colors.white, // ボタンの背景色を白に変更
            foregroundColor: Colors.black, // ボタンの文字の色を黒に変更
            //fixedSize: Size(10, 40), // ボタンの幅を狭めるために縦横固定サイズを設定します
          ),
          child: Text(number.toString()), // 数字を表示します
          onPressed: () {
            setState(() {
              selectedNumber = number; // 選択された数字を更新します
              showButtons = false;
              print(selectedNumber);//動作確認用
            });
          },
        );
      }),
    );
  }
}

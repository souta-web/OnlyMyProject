import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_helper.dart';

// テーマ変更用の状態クラス
class MyTheme extends ChangeNotifier {
  ThemeData current = ThemeData.light();
  bool _isDark = false;

  toggle() {
    _isDark = !_isDark;
    current = _isDark ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }
}

void main() => runApp(MyApp());

// MyApp ウイジェット
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyTheme(),
      child: Consumer<MyTheme>(
        builder: (context, theme, _) {
          return MaterialApp(
            theme: theme.current,
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
}

// MyHomePage ウイジェット
class _MyHomePage extends State<MyHomePage> {
  final String title = "Example";
  bool isButtonToggled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text('テーマ切替テスト'),
            themeChangeButton(isButtonToggled, (bool newValue) {
              setState(() {
                isButtonToggled = newValue;
              });
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:  () {
          Provider.of<MyTheme>(context, listen: false).toggle();
        },
        child: Icon(Icons.autorenew),
      ),

    );
  }
}

Widget themeChangeButton(bool _isToggled, Function(bool) onPressed) {
  return ElevatedButton(
    onPressed: () {
      _isToggled = !_isToggled;
    },
    child: Text(_isToggled ? 'ON' : 'OFF'),
  );
}
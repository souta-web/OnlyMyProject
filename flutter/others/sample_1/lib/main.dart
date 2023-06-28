import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            home: MyHomePage(title: 'Example'),
          );
        },
      ),
    );
  }
}

// MyHomePage ウイジェット
class MyHomePage extends StatelessWidget {
  MyHomePage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('テーマ切替テスト'),
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
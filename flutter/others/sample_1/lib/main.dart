import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_helper.dart';

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
            SwitchButton(),
          ],
        ),
      ),
    );
  }
}

class SwitchButton extends StatefulWidget {
  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isSwitched,
      onChanged: (value) {
        setState(() {
          isSwitched = value;
          Provider.of<MyTheme>(context, listen: false).toggle();
        });
      },
    );
  }
}
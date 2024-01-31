import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// アプリ全体の外観モードの状態を管理するプロバイダー
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

class ConfigScreenWidget extends ConsumerWidget {
  const ConfigScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider.state);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Config"),
        automaticallyImplyLeading: false, // バックボタンを非表示にする
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pushNamed(context, '/main');//routeに追加したconfigに遷移
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SwitchListTile(
             title: Text('ダークモード'),
            value: themeMode.state == ThemeMode.dark,
            onChanged: (value) {
              themeMode.state = value ? ThemeMode.dark : ThemeMode.light;
            },
          ),
        ]
      ),
    );
  }
}
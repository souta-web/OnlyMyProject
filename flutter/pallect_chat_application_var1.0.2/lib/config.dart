import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

class ConfigScreenWidget extends ConsumerWidget {//状態変更をトリガーとして再構築するウィジェット
  const ConfigScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider.state);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Config',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode.state,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider.state);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Config"),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              Navigator.of(context).pop();
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
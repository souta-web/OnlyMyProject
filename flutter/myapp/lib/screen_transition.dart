import 'package:flutter/material.dart';

// 画面遷移に関する情報を管理するクラス
class ScreenTransition {
  /// 遷移元の画面から戻るかどうかを判定するメソッド
  static bool canPop(BuildContext context, String path) {
    // 現在のルートを取得
    final currentRoute = ModalRoute.of(context);

    // 現在のルートが存在し、遷移元の画面から遷移した場合にtrueを返す
    if (currentRoute != null) {
      return currentRoute.settings.name != '/';
    }

    return false;
  }
}

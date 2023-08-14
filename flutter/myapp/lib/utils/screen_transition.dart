import 'package:flutter/material.dart';

// 画面遷移に関する情報を管理するクラス
class ScreenTransition {
  /// 遷移元の画面から戻るかどうかを判定する静的メソッド
  static bool canPop(BuildContext context, String path) {
    // 現在のルートを取得
    final currentRoute = ModalRoute.of(context);

    // 現在のルートが存在し、遷移元の画面から遷移した場合にtrueを返す
    if (currentRoute != null) {
      // 現在のルートがホーム画面('/')でない場合trueを返す
      // つまり、遷移元の画面から遷移した場合にtrueを返す
      return currentRoute.settings.name != '/';
    }

    // 現在のルートがnullの場合(通常はルートが存在しない場合)、falseを返す
    return false;
  }
}

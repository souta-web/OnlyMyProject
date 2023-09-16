import 'package:flutter/material.dart';

// 自動スクロールを行う
class AutoScroll {
  late ScrollController scrollController;

  AutoScroll(ScrollController controller) {
    // コンストラクタの作成
    scrollController = controller;
  }

  // 画面を一番下にスクロールするメソッド
  void scrollToBottom() {
    if (scrollController.hasClients) {
      // スクロールコントローラを使用して画面を一番下にスクロールする
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500), // スクロール時間
        curve: Curves.easeOut, // スクロールの仕方
      );
    }
  }
}

import 'package:flutter/material.dart';

class AutoScroll {
  late ScrollController scrollController;

  AutoScroll(ScrollController controller) {
    scrollController = controller;
    // コンストラクタ内でscrollToBottomを呼び出すこともできます
    scrollToBottom();
  }


  // 画面を一番下にスクロールするメソッド
  void scrollToBottom() {
    if (scrollController.hasClients) {
      // スクロールコントローラを使用して画面を一番下にスクロールする
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 2), // スクロール時間
        curve: Curves.bounceOut, // スクロールの仕方
      );
    }
  }
}

import 'package:flutter/material.dart';

class AutoScroll {
  late ScrollController scrollController;

  AutoScroll(ScrollController controller) {
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

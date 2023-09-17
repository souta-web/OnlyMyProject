import 'package:flutter/material.dart';

// 自動スクロールを行う
class AutoScroll {
  late ScrollController scrollController; // スクロールを制御するためのコントローラ
  late BuildContext context;  // ビルドコンテキスト（ウィジェットツリー内のコンテキスト）

  AutoScroll(ScrollController controller, BuildContext context) {
    // コンストラクタの作成
    scrollController = controller;  // スクロールコントローラーの初期化
    this.context = context; // ビルドコンテキストを初期化
  }

  // 画面を一番下にスクロールするメソッド
  void scrollToBottom() {
    // スクロールコントローラーがクライアント（スクロール可能なウィジェット）を持っている場合に処理を実行
    if (scrollController.hasClients) {
      // スクロールコントローラを使用して画面を一番下にスクロールする
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + // スクロールの最大位置（一番下）
            MediaQuery.of(context).viewInsets.bottom, // ﾋﾞｭーのインセット（ソフトウェアキーボードなどの表示領域）
        duration: const Duration(milliseconds: 500), // スクロール時間
        curve: Curves.easeOut, // スクロールの仕方
      );
    }
  }
}

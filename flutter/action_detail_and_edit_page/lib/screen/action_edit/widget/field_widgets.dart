import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

class ActionEditPagePrimaryWidget extends StatefulWidget {
  ActionEditPagePrimaryWidget({required this.bodyWidth,required this.bodyHeight});
  final double bodyWidth;
  final double bodyHeight;
  @override
  _ActionEditPagePrimaryWidget createState() => _ActionEditPagePrimaryWidget();
}

class _ActionEditPagePrimaryWidget extends State<ActionEditPagePrimaryWidget> {
  //テキストコントローラーの作成。テキストフィールドの値はこれで取得することができる
  final TextEditingController _textEditingController_title = TextEditingController();
  final TextEditingController _textEditingController_score = TextEditingController();
  final TextEditingController _textEditingController_explain = TextEditingController();
  final TextfieldTagsController _textEditingController_tag = TextfieldTagsController(); //タグフィールドのコントローラー
  late double _distanceToField; // TextFieldのサイズ？
  
  @override
  void initState() {
    super.initState();
    _distanceToField = widget.bodyWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children: [
          _createTitleArea(widget.bodyWidth),
          _createTagArea(widget.bodyWidth),
        ]
      )
    );
  }

  Widget _createTitleArea(_bodyWidth) {
    const double _thisHeight = 100.0;
    const Color _hintTextColor = Colors.red;
    return SizedBox(
      width: _bodyWidth,
      height: _thisHeight,
      child: Container(
        child:Column(
          children: [
            TextField(
              controller: _textEditingController_title,
              decoration: const InputDecoration(
                hintText: 'タイトル(hintText)', //ヒントテキスト
                hintStyle: TextStyle(
                  color: _hintTextColor,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                )
              ),
              style: const TextStyle(
                fontSize: 24,
              ),
              onChanged: (value) {
                // テキストが変更されたときの処理
                print('Input: $value');
              },
            ),
          ],
        )
      )
    );
  }

  Widget _createTagArea(_bodyWidth) {
    const double _thisHeight = 200.0;
    const bool _createCLEARTAGS = true;
    late List<String> _tagList = ["料理"]; //タグのリスト
    return SizedBox(
      width: _bodyWidth, 
      height: _thisHeight,
      child: Column(
        children: [
          TextFieldTags(
            textfieldTagsController: _textEditingController_tag, // コントローラーの設定
            initialTags: _tagList, // 最初に表示するタグのリスト
            textSeparators: const [' ', ','], // タグの区切り文字
            //letterCase: LetterCase.normal, // タグの文字の大文字・小文字の設定
            validator: (String tag) { //ユーザーがフィールドに文字を入力してエンターなどで入力確定したときに呼び出される
              if (tag == 'php') {
                return 'No, please just no'; // タグのバリデーション
              } else if (_textEditingController_tag.getTags!.contains(tag) && _textEditingController_tag.getTags != null) {
                return 'you already entered that'; // タグの重複チェック
              }
              return null;
            },
            inputfieldBuilder:(context, tec, fn, error, onChanged, onSubmitted) {
              return ((context, sc, tags, onTagDelete) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: tec, // テキストエディティングコントローラーの設定
                    focusNode: fn, // フォーカスノードの設定
                    decoration: InputDecoration(
                      // テキストフィールドの装飾
                      isDense: true, //若干変わる
                      helperText: 'タグを追加してください', // ヘルパーテキスト
                      hintText: _textEditingController_tag.hasTags ? '' : "Enter tag...", // ヒントテキスト
                      errorText: error, // エラーテキスト
                      prefixIconConstraints:BoxConstraints(maxWidth: _distanceToField * 0.74),
                      prefixIcon: tags.isNotEmpty
                        ? SingleChildScrollView(
                          controller: sc,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: tags.map((String tag) {
                              return _createTagWidget(tag,onTagDelete); //表示用のタグウィジェットを返す
                            }
                          ).toList()),
                        )
                      : null,
                    ),
                    onChanged: onChanged, // テキストが変更されたときのコールバック
                    onSubmitted: onSubmitted, // 送信ボタンが押されたときのコールバック
                  ),
                );
              });
            },
          ),
          _createClearTagsButton(_createCLEARTAGS),
        ],
      ),
    );
  }

  Widget _createTagWidget(String _tag,dynamic _onTagDelete) {
    return Container( //表示するタグのオブジェクト(初期だと緑のやつ)
      decoration: const BoxDecoration( //BoxDecorationでウィジェットの角を丸くする
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: Color.fromARGB(255, 74, 137, 92),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5.0), //ウィジェットの外側の余白
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0), //ウィジェットの内側の余白
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          InkWell( //表示するテキスト(タグの名称)--------
            child: Text(
              '#$_tag',
              style: const TextStyle(
                color: Colors.white),
            ),
            onTap: () {
              print("$_tag selected");
            },
          ), //表示するテキストここまで---------
          const SizedBox(width: 4.0),
          InkWell( //✕ボタンの実装-----------
            child: const Icon(
              Icons.cancel,
              size: 14.0,
              color: Color.fromARGB(
                  255, 233, 233, 233),
            ),
            onTap: () {
              _onTagDelete(_tag);
            },
          )//✕ボタンの実装ここまで--------
        ],
      ),
    );
  }

  Widget _createClearTagsButton(bool _isDraw) { //bool型で表示非表示をコントロールできる
    if (_isDraw) {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 74, 137, 92),
          ),
        ),
        onPressed: () {
          _textEditingController_tag.clearTags(); // タグをクリアする
        },
        child: const Text('CLEAR TAGS'),
      );
    } else {
      return const SizedBox.shrink(); //空のウィジェットを返す
    }
  }

  Widget _createHorizontalLine() {
    const double _thisHeight = 1.5;
    return Divider(
      color: Colors.black, // 線の色を指定 (省略可能)
      height: _thisHeight, // 線の高さを指定 (省略可能)
      thickness: 1.5, // 線の太さを指定 (省略可能)
      indent: 0.0, // 線の開始位置からのオフセットを指定 (省略可能)
      endIndent: 0.0, // 線の終了位置からのオフセットを指定 (省略可能)
    );
  }
}
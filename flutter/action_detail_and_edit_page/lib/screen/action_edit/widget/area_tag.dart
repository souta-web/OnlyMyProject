import 'package:action_detail_and_edit_page/screen/action_edit/widget/field_datas.dart';
import 'package:flutter/material.dart';
import '/widget/create_horizontal_line.dart';
import 'package:textfield_tags/textfield_tags.dart';

class TagArea extends StatefulWidget {
  final double deviceWidth;
  final TextfieldTagsController textFieldTagsController;
  final FieldDatas fieldDatas;

  TagArea({required this.deviceWidth,required this.textFieldTagsController,required this.fieldDatas});

  @override
  _TagArea createState() => _TagArea();
}

class _TagArea extends State<TagArea> {
  late List<String> tagList = [];

  
  void initState() {
    super.initState();
    // 初期化の処理をここに記述する
    tagList.addAll(widget.fieldDatas.tags);
  }
    

  @override
  Widget build(BuildContext context) {
    const bool _createCLEARTAGS = false;
    final double _fieldWidth = widget.deviceWidth;
    final double _drawOnlyTagAreaWidth = _fieldWidth/2;
    return SizedBox(
      width: widget.deviceWidth, 
      //height: _thisHeight,
      child: Column(
        children: [
          TextFieldTags(
            textfieldTagsController: widget.textFieldTagsController, // コントローラーの設定
            initialTags: tagList, // 最初に表示するタグのリスト
            textSeparators: const [' ', ','], // タグの区切り文字
            //letterCase: LetterCase.normal, // タグの文字の大文字・小文字の設定
            validator: (String tag) { //ユーザーがフィールドに文字を入力してエンターなどで入力確定したときに呼び出される
              if (tag == 'php') {
                return 'No, please just no'; // タグのバリデーション
              } else if (widget.textFieldTagsController.getTags!.contains(tag) && widget.textFieldTagsController.getTags != null) {
                return 'you already entered that'; // タグの重複チェック
              }
              return null;
            },
            inputfieldBuilder:(context, tec, fn, error, onChanged, onSubmitted) { //入力欄
              return ((context, sc, tags, onTagDelete) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: tec, // テキストエディティングコントローラーの設定
                    focusNode: fn, // フォーカスノードの設定
                    decoration: InputDecoration(
                      // テキストフィールドの装飾
                      isDense: true, //若干変わる
                      hintText: widget.textFieldTagsController.hasTags ? '' : "タグを追加してください。", // ヒントテキスト
                      prefixIconConstraints:BoxConstraints(maxWidth: _drawOnlyTagAreaWidth),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
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
                    onChanged: onChanged,// テキストが変更されたときのコールバック
                    onSubmitted: (String tag) {
                      // テキストが変更されたときの処理
                      
                      tags.add(tag);
                      //↓タグのバック処理
                      tagList.add(tag);
                      widget.fieldDatas.tags.clear();
                      widget.fieldDatas.tags.addAll(tagList);
                      print(widget.fieldDatas.tags);
                    },// 送信ボタンが押されたときのコールバック
                  ),
                );
              });
            },
          ),
          HorizontalLine(),
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
          widget.textFieldTagsController.clearTags(); // タグをクリアする
        },
        child: const Text('CLEAR TAGS'),
      );
    } else {
      return const SizedBox.shrink(); //空のウィジェットを返す
    }
  }
}
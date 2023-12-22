import 'package:flutter/material.dart';
import 'dart:typed_data';

class CreateImages extends StatelessWidget {
  final String text;
  final List<Uint8List> images;
  final String? time;

  CreateImages({
    required this.text,
    required this.images,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 149, 21),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 10.0),
                if (images.length == 1)
                  Image.memory(
                    images[0],
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                else
                  Container(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.memory(
                          images[index],
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            left: -10,
            bottom: 0,
            child: _createTimeWidget(time),
          ),
        ],
      ),
    );
  }

  Widget _createTimeWidget(String? time) {
    if (time != null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
        alignment: Alignment.bottomCenter,
        child: Text(
          time,
          style: TextStyle(fontSize: 12.0, color: Colors.grey),
        ),
      );
    } else {
      return const SizedBox(); // 空のウィジェットを返す
    }
  }
}

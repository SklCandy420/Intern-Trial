import 'package:flutter/material.dart';

class ImgPage extends StatelessWidget {
  final Map _gifData;
  ImgPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(_gifData['urls']['small']),
      ),
    );
  }
}

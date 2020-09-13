import 'dart:io';

import 'package:com.codestagevn.gridpicture/language.dart';
import 'package:com.codestagevn.gridpicture/screens/editor/common/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intent/intent.dart' as intent;
import 'package:intent/action.dart' as action;
import 'package:intent/category.dart' as category;



class ShareScreen extends StatelessWidget {
  final List<File> files;
  final CropNumber number;
  const ShareScreen(this.files, this.number);

  Widget _buildImage(double size) {

    print('Crop num: $number');

    List<Widget> images = [];
    if(number == CropNumber.Three) {
      images.add(Image.file(files[0], fit: BoxFit.fitWidth));
      images.add(SizedBox(height: 2));
      images.add(Row(
        children: [
          Image.file(files[1], width: size / 2 - 1, fit: BoxFit.fitWidth),
          SizedBox(width: 2),
          Image.file(files[2], width: size / 2 - 1, fit: BoxFit.fitWidth)
        ],
      ));
    } else if(number == CropNumber.Four) {
      images.add(Image.file(files[0], fit: BoxFit.fitWidth));
      images.add(SizedBox(height: 1.5));
      images.add(Row(
        children: [
          Image.file(files[1], width: size / 3 - 1, fit: BoxFit.fitWidth),
          SizedBox(width: 1.5),
          Image.file(files[2], width: size / 3 - 1, fit: BoxFit.fitWidth),
          SizedBox(width: 1.5),
          Image.file(files[2], width: size / 3 - 1, fit: BoxFit.fitWidth)
        ],
      ));
    } else if(number == CropNumber.Nine) {
      for(int i = 0; i < 9; i += 3) {
        images.add(Row(
          children: [
            Image.file(files[i], width: size / 3 - 1, fit: BoxFit.fitWidth),
            SizedBox(width: 1.5),
            Image.file(files[i + 1], width: size / 3 - 1, fit: BoxFit.fitWidth),
            SizedBox(width: 1.5),
            Image.file(files[i + 2], width: size / 3 - 1, fit: BoxFit.fitWidth)
          ],
        ));
        if(i < 9) {
          images.add(SizedBox(height: 1.5));
        }
      }
    } else if(number == CropNumber.TwoV) {
      images.add(
        Row(
          children: [
            Image.file(files[0], width: size / 2 - 1, fit: BoxFit.fitWidth),
            SizedBox(width: 2),
            Image.file(files[1], width: size / 2 - 1, fit: BoxFit.fitWidth),
          ],
        )
      );
    } else {
      images.add(Image.file(files[0], fit: BoxFit.fitWidth));
      images.add(SizedBox(height: 2));
      images.add(Image.file(files[1], fit: BoxFit.fitWidth));
    }

    return Column(
      children: images,
    );
  }

  @override
  Widget build(BuildContext context) {
    var folder = files[0].path.split('/');
    folder.removeLast();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLg.of(context).trans('saved')),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: _buildImage(MediaQuery.of(context).size.width - 40)
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.folder, color: Colors.orange, size: 40),
                SizedBox(width: 10),
                Expanded(child: Text(folder.join('/'))),
              ],
            ),
            SizedBox(height: 30),
            CupertinoButton(
              onPressed: () => null,
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.facebookF),
                  SizedBox(width: 10),
                  Text(AppLg.of(context).trans('share_facebook'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
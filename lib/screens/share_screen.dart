import 'dart:io';
import 'package:com.codestagevn.gridpicture/language.dart';
import 'package:com.codestagevn.gridpicture/screens/editor/common/constants.dart';
import 'package:com.codestagevn.gridpicture/services/admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';

class ShareScreen extends StatefulWidget {
  final List<File> files;
  final CropNumber number;

  ShareScreen(this.files, this.number);

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  void initState() {
    super.initState();
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        AdmobService.interstitial.isLoaded().then((value) {
      if(value) {
        AdmobService.showInterstitial();
      }
    });
  }

  @override
  void dispose() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    super.dispose();
  }

  Widget _buildImage(double size) {

    print('Crop num: ${widget.number}');

    List<Widget> images = [];
    if(widget.number == CropNumber.Three) {
      images.add(Image.file(widget.files[0], width: size, fit: BoxFit.fitWidth));
      images.add(SizedBox(height: 2));
      images.add(Row(
        children: [
          Image.file(widget.files[1], width: size / 2 - 1, fit: BoxFit.fitWidth),
          SizedBox(width: 2),
          Image.file(widget.files[2], width: size / 2 - 1, fit: BoxFit.fitWidth)
        ],
      ));
    } else if(widget.number == CropNumber.Four) {
      images.add(Image.file(widget.files[0], fit: BoxFit.fitWidth));
      images.add(SizedBox(height: 1.5));
      images.add(Row(
        children: [
          Image.file(widget.files[1], width: size / 3 - 1, fit: BoxFit.fitWidth),
          SizedBox(width: 1.5),
          Image.file(widget.files[2], width: size / 3 - 1, fit: BoxFit.fitWidth),
          SizedBox(width: 1.5),
          Image.file(widget.files[3], width: size / 3 - 1, fit: BoxFit.fitWidth)
        ],
      ));
    } else if(widget.number == CropNumber.Nine) {
      for(int i = 0; i < 9; i += 3) {
        images.add(Row(
          children: [
            Image.file(widget.files[i], width: size / 3 - 1, fit: BoxFit.fitWidth),
            SizedBox(width: 1.5),
            Image.file(widget.files[i + 1], width: size / 3 - 1, fit: BoxFit.fitWidth),
            SizedBox(width: 1.5),
            Image.file(widget.files[i + 2], width: size / 3 - 1, fit: BoxFit.fitWidth)
          ],
        ));
        if(i < 9) {
          images.add(SizedBox(height: 1.5));
        }
      }
    } else if(widget.number == CropNumber.TwoV) {
      images.add(
        Row(
          children: [
            Image.file(widget.files[0], width: size / 2 - 1, fit: BoxFit.fitWidth),
            SizedBox(width: 2),
            Image.file(widget.files[1], width: size / 2 - 1, fit: BoxFit.fitWidth),
          ],
        )
      );
    } else {
      images.add(Image.file(widget.files[0], fit: BoxFit.fitWidth));
      images.add(SizedBox(height: 2));
      images.add(Image.file(widget.files[1], fit: BoxFit.fitWidth));
    }

    return Column(
      children: images,
    );
  }

  @override
  Widget build(BuildContext context) {
    var folder = widget.files[0].path.split('/');
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
                Icon(Icons.check, color: Colors.green, size: 40),
                SizedBox(width: 10),
                Expanded(child: Text(AppLg.of(context).trans('saved_at') + ': ' + folder.join('/'))),
              ],
            ),
            SizedBox(height: 20),
            RatingBar(
              initialRating: 0,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                LaunchReview.launch(androidAppId: "com.codestagevn.gridpicture");
              },
            ),
            SizedBox(height: 30),
            CupertinoButton(
              onPressed: () {
                List<String> filePaths = List<String>.from(widget.files.map((e) => e.path));
                Share.shareFiles(filePaths);
              },
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share),
                  SizedBox(width: 10),
                  Text(AppLg.of(context).trans('share_now'))
                ],
              ),
            ),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
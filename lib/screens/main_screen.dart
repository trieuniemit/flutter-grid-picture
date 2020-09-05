import 'dart:io';
import 'package:app.gridpicture/config/routes.dart';
import 'package:app.gridpicture/services/admob.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:native_flutter_admob/native_flutter_admob.dart';
import 'editor/editor_screen.dart';

class MainScreen extends StatelessWidget {
  final picker = ImagePicker();

  Future _getImage(ImageSource source, context) async {
     final pickedFile = await picker.getImage(source: source);
    Routes.pushTo(context, EditorScreen(
      image: File(pickedFile.path),
      maximumScale: 5,
      chipShape: 'rect',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('resources/images/background.png')
            )
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child:  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: NativeAdmobBannerView(
                      adUnitID: NativeAd.testAdUnitId,
                      style: BannerStyle.light,
                      showMedia: true,
                      testDevices: AdmobService.testDevices,
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                        onPressed: () => _getImage(ImageSource.camera, context),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(35),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.all(Radius.circular(70))
                              ),
                              child: Icon(Icons.camera_alt, size: 45, color: Colors.white),
                            ),
                            Text('Chụp ảnh', style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () => _getImage(ImageSource.gallery, context),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(35),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.all(Radius.circular(70))
                              ),
                              child: Icon(Icons.photo_library, size: 45, color: Colors.white),
                            ),
                            Text('Thư viện', style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
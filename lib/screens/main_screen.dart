import 'dart:io';
import 'package:app.gridpicture/config/routes.dart';
import 'package:app.gridpicture/language.dart';
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

  Widget _buildAppBar(context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: RichText(
        text: TextSpan(
            text: 'Grid',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),
            children: [
              TextSpan(
                  text: ' Pictures',
                  style: TextStyle(
                      fontWeight: FontWeight.normal
                  )
              )
            ]
        ),
      ),
      actions: [
        CupertinoButton(
          onPressed: () => null,
          child: Icon(Icons.share, size: 26, color: Colors.white),
        ),
        CupertinoButton(
          onPressed: () => Navigator.of(context).pushNamed(Routes.setting),
          child: Icon(Icons.settings, size: 26, color: Colors.white),
        )
      ],
    );
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
                _buildAppBar(context),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child:  Column(
                    children: [
//                      ClipRRect(
//                        borderRadius: BorderRadius.all(Radius.circular(15)),
//                        child: NativeAdmobBannerView(
//                          adUnitID: NativeAd.testAdUnitId,
//                          style: BannerStyle.light,
//                          showMedia: true,
//                          testDevices: AdmobService.testDevices,
//                          contentPadding: EdgeInsets.all(8),
//                        ),
//                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                repeat: ImageRepeat.repeatX,
                                image: AssetImage('resources/images/home_icon.gif')
                            )
                        ),
                      ),
                    ],
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
                            Text(AppLg.of(context).trans('camera'),
                                style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white)
                            )
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
                            Text(AppLg.of(context).trans('gallery'),
                                style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white)
                            )
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
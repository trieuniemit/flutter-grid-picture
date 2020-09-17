import 'dart:io';
import 'package:com.codestagevn.gridpicture/config/routes.dart';
import 'package:com.codestagevn.gridpicture/language.dart';
import 'package:com.codestagevn.gridpicture/services/admob.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:native_flutter_admob/native_flutter_admob.dart';
import 'package:share/share.dart';
import 'editor/editor_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final picker = ImagePicker();
  bool _isShowAds = true;

  Future _getImage(ImageSource source, context) async {
    final pickedFile = await picker.getImage(source: source);
    Routes.pushTo(context, EditorScreen(
      image: File(pickedFile.path),
      maximumScale: 5,
      chipShape: 'rect',
    ));
  }

  void _shareApp(context) {
    Share.share(AppLg.of(context).trans('share_desc'));
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
          onPressed: () => _shareApp(context),
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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('resources/images/background.png')
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              margin: EdgeInsets.only(bottom: 20),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: _isShowAds ? NativeAdmobBannerView(
                    adUnitID: NativeAd.testAdUnitId,
                    style: BannerStyle.light,
                    showMedia: true,
                    onCreate: (controller) {
                      controller.onAdFailedToLoad = () {
                        setState(() { _isShowAds = false;});
                      };
                    },
                    testDevices: AdmobService.testDevices,
                    contentPadding: EdgeInsets.all(8),
                  ) : Container(
                    //implement here
                  ),
              ),
            ),
            Row(
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
                ),
              ],
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
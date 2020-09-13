import 'package:com.codestagevn.gridpicture/config/constants.dart';
import 'package:com.codestagevn.gridpicture/helpers/file_helpers.dart';
import 'package:com.codestagevn.gridpicture/language.dart';
import 'package:com.codestagevn.gridpicture/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {

  void _bugReport(context) async {
    var uri = 'mailto:$BUG_REPORT_MAIL?subject=Grid Picture: ${AppLg.of(context).trans('report_bugs')}';
    if(await canLaunch(uri)) {
      await launch(uri);
    }
  }

  void _rateApp(context) async {
    if(await canLaunch(RATING_URL)) {
      await launch(RATING_URL);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLg.of(context).trans('setting')),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            ListTile(
              onTap: () => _bugReport(context),
              leading: Icon(Icons.bug_report, size: 40, color: Colors.green),
              title: Text(
                  AppLg.of(context).trans('report_bugs'),
                  style: TextStyle(color: Colors.black)
              ),
              subtitle: Text(AppLg.of(context).trans('report_bugs_desc')),
            ),
            Divider(),
            ListTile(
              onTap: () => _rateApp(context),
              leading: Icon(Icons.star, size: 40, color: Colors.amber,),
              title: Text(
                  AppLg.of(context).trans('rate_app'),
                  style: TextStyle(color: Colors.black)
              ),
              subtitle: Text(AppLg.of(context).trans('rate_app_desc')),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.folder, size: 37, color: Colors.orange),
              title: Text(
                  AppLg.of(context).trans('pictures_folder'),
                  style: TextStyle(color: Colors.black)
              ),
              subtitle: Text(FileHelper.pictureFolder),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info, size: 40,color: Colors.blue),
              title: Text(
                  AppLg.of(context).trans('app_version'),
                  style: TextStyle(color: Colors.black)
              ),
              subtitle: Text(AppLg.of(context).trans('version') + ' ${App.version}'),
            )
          ],
        ),
      ),
    );
  }

}
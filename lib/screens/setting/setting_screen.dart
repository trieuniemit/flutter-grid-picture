import 'package:app.gridpicture/helpers/file_helpers.dart';
import 'package:app.gridpicture/language.dart';
import 'package:app.gridpicture/main.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
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
              onTap: () => null,
              leading: Icon(Icons.folder, size: 37, color: Colors.orange),
              title: Text(
                  AppLg.of(context).trans('pictures_folder'),
                  style: TextStyle(color: Colors.black)
              ),
              subtitle: Text(FileHelper.pictureFolder),
            ),
            Divider(),
            ListTile(
              onTap: () => null,
              leading: Icon(Icons.bug_report, size: 40, color: Colors.green),
              title: Text(
                  AppLg.of(context).trans('report_bugs'),
                  style: TextStyle(color: Colors.black)
              ),
              subtitle: Text(AppLg.of(context).trans('report_bugs_desc')),
            ),
            Divider(),
            ListTile(
              onTap: () => null,
              leading: Icon(Icons.star, size: 40, color: Colors.amber,),
              title: Text(
                  AppLg.of(context).trans('rate_app'),
                  style: TextStyle(color: Colors.black)
              ),
              subtitle: Text(AppLg.of(context).trans('rate_app_desc')),
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
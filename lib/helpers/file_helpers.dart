import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';

class FileHelper {

  static String pictureFolder = '';

  static Future<String> getDocumentDirectory({String folder = ''}) async {
    Directory baseDir;
    if (Platform.isAndroid) {
      try {
        baseDir = Directory((await PathProviderEx.getStorageInfo()).first.rootDir);
      } on PlatformException {
        baseDir = await getExternalStorageDirectory();
      }
    } else {
      baseDir = await getApplicationDocumentsDirectory();
    }
    return baseDir.path + '/' + folder;
  }

  static Future<void> createAppDirectories() async {
    if (await Permission.storage .request() .isGranted) {
      String rootDir = await getDocumentDirectory();
      pictureFolder = rootDir + 'Pictures/GridPictures';

      List<String> dirToBeCreated = ['$rootDir/Pictures', pictureFolder];

      dirToBeCreated.forEach((path) async {
        var dir = Directory(path);
        bool dirExists = await dir.exists();
        if (!dirExists) {
          dir.create();
        }
      });
    }
  }
}


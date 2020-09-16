import 'package:com.codestagevn.gridpicture/screens/editor/common/constants.dart';
import 'package:com.codestagevn.gridpicture/screens/editor/widgets/loading.dart';
import 'package:flutter/material.dart';

List<Rect> getCropAreasOfImage(Rect area, CropNumber cropNumber) {
  List<Rect> areas = [];

  switch(cropNumber) {
    case CropNumber.TwoH:
      areas.add(Rect.fromLTWH(area.left, area.top, area.width, area.height / 2));
      areas.add(Rect.fromLTWH(area.left, area.top + area.height / 2, area.width, area.height / 2));
    break;
    case CropNumber.TwoV:
      areas.add(Rect.fromLTWH(area.left, area.top, area.width / 2, area.height));
      areas.add(Rect.fromLTWH(area.left + area.width / 2, area.top, area.width / 2, area.height));
      break;
    case CropNumber.Three:
      areas.add(Rect.fromLTWH(area.left, area.top, area.width, area.height * 2/3));
      areas.add(Rect.fromLTWH(area.left, area.top + area.height * 2/3, area.width / 2, area.height * 1/3));
      areas.add(Rect.fromLTWH(area.left + area.width / 2, area.top + area.height * 2/3, area.width / 2, area.height * 1/3));
      break;
    case CropNumber.Four:
      areas.add(Rect.fromLTWH(area.left, area.top, area.width, area.height * 2/3));
      areas.add(Rect.fromLTWH(area.left, area.top + area.height * 2/3, area.width * 1/3, area.height * 1/3));
      areas.add(Rect.fromLTWH(area.left + area.width * 1/3, area.top + area.height * 2/3, area.width * 1/3, area.height * 1/3));
      areas.add(Rect.fromLTWH(area.left + area.width * 2/3, area.top + area.height * 2/3, area.width * 1/3, area.height * 1/3));
      break;
    case CropNumber.Nine:
      double size = area.width / 3;

      for(int i = 0; i < 3; i++) {
        for(int j = 0; j < 3; j++) {
          areas.add(Rect.fromLTWH(
              area.left + size * j,
              area.top + size * i,
              size,
              size
          ));
        }
      }
      break;
  }

  print('Crop areas: $areas');
  return areas;
}

void showLoading(context) {
  showDialog(
    barrierDismissible: false,
    barrierColor: Colors.black54,
    context: context,
    builder: (context) {
      return Loading();
    }
  );
}
import 'package:app.gridpicture/screens/editor/common/constants.dart';
import 'package:flutter/material.dart';

List<Rect> getAreasOfImage(Rect area, CropNumber cropNumber) {
  List<Rect> areas = [];

  switch(cropNumber) {
    case CropNumber.TwoH:
      areas.add(Rect.fromLTWH(area.left, area.top, area.width, area.height / 2));
      areas.add(Rect.fromLTWH(area.left, area.center.dy, area.width, area.height / 2));
    break;
    case CropNumber.TwoV:
      areas.add(Rect.fromLTWH(area.left, area.top, area.width / 2, area.height));
      areas.add(Rect.fromLTWH(area.center.dy, area.top, area.width / 2, area.height));
      break;
    case CropNumber.Three:
      areas.add(Rect.fromLTWH(area.left, area.top, area.width, area.height * 2/3));
      areas.add(Rect.fromLTWH(area.left, area.bottom * 2/3, area.width / 2, area.height * 1/3));
      areas.add(Rect.fromLTWH(area.right / 2, area.bottom * 2/3, area.width / 2, area.height * 1/3));
      break;
    case CropNumber.Four:
      areas.add(Rect.fromLTWH(area.left, area.top, area.width, area.bottom * 2/3));
      areas.add(Rect.fromLTWH(area.left, area.bottom * 2/3, area.width * 1/3, area.height * 1/3));
      areas.add(Rect.fromLTWH(area.right * 1/3, area.bottom * 2/3, area.width * 1/3, area.height * 1/3));
      areas.add(Rect.fromLTWH(area.right * 2/3, area.bottom * 2/3, area.width * 1/3, area.height * 1/3));
      break;
    case CropNumber.FourEvenly:
      // TODO: Handle this case.
      break;
  }

  return areas;
}
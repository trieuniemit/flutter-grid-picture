import 'package:app.gridpicture/screens/editor/common/constants.dart';
import 'package:flutter/material.dart';

List<Rect> getCropAreasOfImage(Rect area, CropNumber cropNumber) {
  List<Rect> areas = [];

  switch(cropNumber) {
    case CropNumber.TwoH:
      areas.add(Rect.fromLTRB(area.left, area.top, area.right, area.bottom / 2));
      areas.add(Rect.fromLTRB(area.left, area.bottom / 2, area.right, area.bottom));
    break;
    case CropNumber.TwoV:
      areas.add(Rect.fromLTRB(area.left, area.top, area.right / 2, area.bottom));
      areas.add(Rect.fromLTRB(area.right/2, area.top, area.right, area.bottom));
      break;
    case CropNumber.Three:
      areas.add(Rect.fromLTRB(area.left, area.top, area.right, area.bottom * 2/3));
      areas.add(Rect.fromLTRB(area.left, area.bottom * 2/3, area.right / 2, area.bottom));
      areas.add(Rect.fromLTRB(area.right / 2, area.bottom * 2/3, area.right, area.bottom));
      break;
    case CropNumber.Four:
      areas.add(Rect.fromLTRB(area.left, area.top, area.right, area.bottom * 2/3));
      areas.add(Rect.fromLTRB(area.left, area.bottom * 2/3, area.right * 1/3, area.bottom));
      areas.add(Rect.fromLTRB(area.right * 1/3, area.bottom * 2/3, area.right * 2/3, area.bottom));
      areas.add(Rect.fromLTRB(area.right * 2/3, area.bottom * 2/3, area.right, area.bottom));
      break;
    case CropNumber.Nine:
      for(int i = 1; i <= 3; i++) {
        for(int j = 1; j <= 3; j++) {
          areas.add(Rect.fromLTRB(
              area.right - (area.right * (3 - j) / 3) - area.right * 1/3,
              area.bottom - (area.bottom * (3 - i) / 3) - area.bottom * 1/3,
              area.right - (area.right * (3 - j) / 3), //
              area.bottom - (area.bottom * (3 - i) / 3)
          ));
        }
      }
      break;
  }

  return areas;
}
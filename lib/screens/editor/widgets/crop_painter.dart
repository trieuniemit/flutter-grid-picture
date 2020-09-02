import 'dart:math';
import '../common/constants.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CropPainter extends CustomPainter {
  final ui.Image image;
  final Rect view;
  final double ratio;
  final Rect area;
  final double scale;
  final double active;
  final String chipShape;
  final CropNumber cropNumber;

  CropPainter({this.image,
      this.view,
      this.ratio,
      this.area,
      this.scale,
      this.active,
      this.chipShape,
      this.cropNumber = CropNumber.Three
  });

  @override
  bool shouldRepaint(CropPainter oldDelegate) {
    return oldDelegate.image != image ||
        oldDelegate.view != view ||
        oldDelegate.ratio != ratio ||
        oldDelegate.area != area ||
        oldDelegate.active != active ||
        oldDelegate.scale != scale ||
        oldDelegate.cropNumber != cropNumber;
  }

  currentRect(size) {
    return Rect.fromLTWH(
      kCropHandleSize / 2,
      kCropHandleSize / 2,
      size.width - kCropHandleSize,
      size.height - kCropHandleSize,
    );
  }

  Rect currentBoundaries(size) {
    var rect = currentRect(size);
    return Rect.fromLTWH(
      rect.width * area.left,
      rect.height * area.top,
      rect.width * area.width,
      rect.height * area.height,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = currentRect(size);

    canvas.save();
    canvas.translate(rect.left, rect.top);

    final paint = Paint()..isAntiAlias = false;

    if (image != null) {
      final src = Rect.fromLTWH(
        0.0,
        0.0,
        image.width.toDouble(),
        image.height.toDouble(),
      );
      final dst = Rect.fromLTWH(
        view.left * image.width * scale * ratio,
        view.top * image.height * scale * ratio,
        image.width * scale * ratio,
        image.height * scale * ratio,
      );

      canvas.save();
      canvas.clipRect(Rect.fromLTWH(0.0, 0.0, rect.width, rect.height));
      canvas.drawImageRect(image, src, dst, paint);
      canvas.restore();
    }

    paint.color = Color.fromRGBO(0x0, 0x0, 0x0,
        kCropOverlayActiveOpacity * active + kCropOverlayInactiveOpacity * (1.0 - active)
    );

    final boundaries = currentBoundaries(size);

    final _path1 = Path()..addRect(Rect.fromLTRB(0.0, 0.0, rect.width, rect.height));
    final _path2 = Path()..addRect(boundaries);


    drawGrid(canvas, boundaries, size);

    canvas.clipPath(Path.combine(PathOperation.difference, _path1, _path2));
    // overlay
    canvas.drawRect(Rect.fromLTRB(0.0, 0.0, rect.width, rect.height), paint);
    canvas.restore();
  }

  void drawGrid(Canvas canvas, Rect bound, Size size) {
    Paint paint = Paint()
      ..isAntiAlias = true
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path gridPath = Path();

    // draw rect
    gridPath.moveTo(bound.topLeft.dx,  bound.topLeft.dy);
    gridPath.lineTo(bound.topRight.dx,  bound.topRight.dy);
    gridPath.lineTo(bound.bottomRight.dx,  bound.bottomRight.dy);
    gridPath.lineTo(bound.bottomLeft.dx,  bound.bottomLeft.dy);
    gridPath.lineTo(bound.topLeft.dx,  bound.topLeft.dy);

    double y = (bound.top + (bound.bottom - bound.top) / 3 * 2);

    // draw grid
    if(cropNumber == CropNumber.TwoV) {
      gridPath.moveTo(bound.centerLeft.dx, bound.centerLeft.dy);
      gridPath.lineTo(bound.centerRight.dx, bound.centerRight.dy);

    } else if(cropNumber == CropNumber.TwoH) {
      gridPath.moveTo(bound.topCenter.dx, bound.topCenter.dy);
      gridPath.lineTo(bound.bottomCenter.dx, bound.bottomCenter.dy);

    } else if(cropNumber == CropNumber.Three) {
      gridPath.moveTo(bound.left, y);
      gridPath.lineTo(bound.right, y);
      gridPath.moveTo(bound.topCenter.dx, y);
      gridPath.lineTo(bound.bottomCenter.dx, bound.bottomCenter.dy);

    } else if(cropNumber == CropNumber.FourEvenly) {
      gridPath.moveTo(bound.topCenter.dx, bound.topCenter.dy);
      gridPath.lineTo(bound.bottomCenter.dx, bound.bottomCenter.dy);
      gridPath.moveTo(bound.centerLeft.dx, bound.centerLeft.dy);
      gridPath.lineTo(bound.centerRight.dx, bound.centerRight.dy);

    } else if(cropNumber == CropNumber.Four) {
      gridPath.moveTo(bound.left, y);
      gridPath.lineTo(bound.right, y);

      double x = (bound.left + (bound.right - bound.left) / 3);

      gridPath.moveTo(x, y);
      gridPath.lineTo(x, bound.bottom);

      gridPath.moveTo(x * 2, y);
      gridPath.lineTo(x * 2, bound.bottom);
    }
    canvas.drawPath(gridPath, paint);
  }
}
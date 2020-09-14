import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

class ImageOptions {
  final int width;
  final int height;

  ImageOptions({this.width, this.height})
      : assert(width != null),
        assert(height != null);

  @override
  int get hashCode => hashValues(width, height);

  @override
  bool operator ==(other) {
    return other is ImageOptions &&
        other.width == width &&
        other.height == height;
  }

  @override
  String toString() {
    return '$runtimeType(width: $width, height: $height)';
  }
}

class EditorChannel {
  static const _channel = const MethodChannel('app.gribpicture/image_crop');

  static Future<ImageOptions> getImageOptions({File file}) async {
    assert(file != null);
    final result =
    await _channel.invokeMethod('getImageOptions', {'path': file.path});
    return ImageOptions(
      width: result['width'],
      height: result['height'],
    );
  }

  static Future<File> cropImage({
    File file,
    Rect area,
    double scale,
  }) {
    assert(file != null);
    assert(area != null);
    return _channel.invokeMethod('cropImage', {
      'path': file.path,
      'left': area.left,
      'top': area.top,
      'right': area.right,
      'bottom': area.bottom,
      'scale': scale ?? 1.0,
    }).then<File>((result) => File(result));
  }

}
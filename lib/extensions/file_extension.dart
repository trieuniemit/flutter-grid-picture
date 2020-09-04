import 'dart:io';

extension FileExtension on File {
  String get name => this.path.split("/").last;
  String get ext => this.path.split(".").last;
}
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'dart:io';

class ImageService {
  List<ParseFile> convertToParseFiles(List<File> images) {
    List<ParseFile> uploads = [];
    images.forEach((File img) {
      ParseFile parseFile = ParseFile(img);
      parseFile.upload(progressCallback: (a, b) {
        print('Uploading: $a, $b');
      });
      uploads.add(parseFile);
    });
    return uploads;
  }
}

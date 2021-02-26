import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'dart:io';

class ImageHandler {
  Future<List<File>> convertListAssetToListFile(List<Asset> assets) async {
    List<File> files = [];
    for (int i = 0; i < assets.length; i++) {
      String imgPath =
          await FlutterAbsolutePath.getAbsolutePath(assets[i].identifier);
      File file = File(imgPath);
      files.add(file);
    }
    return files;
  }

  Future<List<List<int>>> createFilesFromAssets(List<Asset> files) async {
    List<List<int>> images = [];
    for (int i = 0; i < files.length; i++) {
      List<int> image = await createFileFromAsset(files[i]);
      images.add(image);
    }
    return images;
  }

  Future<List<int>> createFileFromAsset(Asset asset) async {
    try {
      ByteData byteData = await asset.getByteData();
      ByteBuffer byteBuffer = byteData.buffer;
      List<int> imageData = byteBuffer.asUint8List(
          byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
      // File image = File.fromRawPath(imageData);
      // return image;
    } catch (err) {
      print('Error creating File: $err');
      return null;
    }
  }
}

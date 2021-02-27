import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ImageHandler {
  Future<List<File>> convertListAssetToListFile(List<Asset> assets) async {
    List<File> files = [];
    for (int i = 0; i < assets.length; i++) {
      String imgPath =
          await FlutterAbsolutePath.getAbsolutePath(assets[i].identifier);
      // File file = File(imgPath);
      var bytes = await compressImage(imgPath);
      var file = await convertUint8ListToFile(bytes, assets[i].identifier);
      files.add(file);
    }
    return files;
  }

  Future<File> convertUint8ListToFile(Uint8List bytes, String i) async {
    final tmpDir = await getTemporaryDirectory();
    final file = await File('${tmpDir.path}/$i.jpeg').create(recursive: true);
    file.writeAsBytesSync(bytes);
    return file;
  }

  Future<Uint8List> compressImage(String img) async {
    var result = await FlutterImageCompress.compressAssetImage(
      img,
      minWidth: 600,
      quality: 80,
      format: CompressFormat.jpeg,
    );
    // String
    return result;
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

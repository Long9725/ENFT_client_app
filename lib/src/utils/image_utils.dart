import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class ImageUtils {
  final ImagePicker _picker = ImagePicker();

  ImageUtils();

  Future<List<XFile>?> pickMultiImg() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    return images;
  }

  // convert image to base64
  Future<String> imgToBase64(File img) async {
    Uint8List imgBytes = await img.readAsBytes(); // convert to bytes
    String base64String = base64.encode(imgBytes); //convert bytes to base64 string
    print(base64String);
    return base64String;
  }
}
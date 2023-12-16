import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:FdisTesting/models/element_by_id_model.dart';
import 'package:FdisTesting/models/error_type_model.dart';
import 'package:FdisTesting/models/last_page_model.dart';
import 'package:http/http.dart' as http;
import 'package:FdisTesting/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as imageCompresser;
import 'package:path/path.dart';

class CreateErrorProvider with ChangeNotifier {
  final api = Api();
  ElementByIdModel elementByIdModel = ElementByIdModel();
  ErrorTypeModel errorTypeModel = ErrorTypeModel();
  Rows? selectedElementValue;
  ErrorData? selectedErrorValue;
  File? logBoekImage;
  File? technischeImage;
  late PermissionStatus _permissionStatus;

  int _counts = 0;

  int get count => _counts;

  Future<void> cameraPermission() async {
    final status = await Permission.camera.request();
    _permissionStatus = status;
    notifyListeners();
  }

  Future<void> compressImage(String inputPath, String outputPath) async {
    try {
      // Read the image from file
      File inputFile = File(inputPath);
      var inputBytes = inputFile.readAsBytesSync();
      var image = imageCompresser.decodeImage(inputBytes);

      // Set the compression level (0 to 100, 100 being the best quality)
      int compressionLevel = 80;

      // Compress the image
      List<int> compressedBytes =
          imageCompresser.encodeJpg(image!, quality: 50);

      // Write the compressed image to a new file
      var file = File(outputPath);
      file.writeAsBytesSync(compressedBytes);
      print('Compressed file size ${await file.length()}');
      return print('Image compressed successfully. Output path: $outputPath');
    } catch (e) {
      print('Error compressing image: $e');
    }
  }

  Future<bool> isFileSizeBelowLimit(String filePath, int maxSizeInBytes) async {
    try {
      File file = File(filePath);
      int fileSize = await file.length();

      // Compare the file size with the maximum allowed size
      return fileSize <= maxSizeInBytes;
    } catch (e) {
      // Handle any errors, such as file not found
      print('Error checking file size: $e');
      return false;
    }
  }

  Future<void> logBoekCaptureImage(BuildContext context) async {
    if (logBoekImage == null) {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        String directoryPath = dirname(image.path);
        print(
            "logBoekCaptureImage===${directoryPath}/${image.name.split('.').first}");
        var compresPath =
            "${directoryPath}/${image.name.split('.').first}_compressed.jpg";
        compressImage(image.path, compresPath);

        bool isFileSizeValid =
            await isFileSizeBelowLimit(compresPath, 5 * 1024 * 1024);

        if (isFileSizeValid) {
          // Proceed with the file upload or other operations
          print('File size is valid. Uploading file...');
          logBoekImage = File(compresPath);
          // Your upload logic goes here
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'File size exceeds the limit of 5MB. Choose a smaller file.')));
        }
      }
      notifyListeners();
    }
  }

  Future<void> technischeCaptureImage(BuildContext context) async {
    if (technischeImage == null) {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        String directoryPath = dirname(image.path);
        print(
            "technischeImage===${directoryPath}/${image.name.split('.').first}");
        var compresPath =
            "${directoryPath}/${image.name.split('.').first}_compressed.jpg";
        compressImage(image.path, compresPath);
        bool isFileSizeValid =
            await isFileSizeBelowLimit(compresPath, 5 * 1024 * 1024);

        if (isFileSizeValid) {
          // Proceed with the file upload or other operations
          print('File size is valid. Uploading file...');
          technischeImage = File(compresPath);
          // Your upload logic goes here
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'File size exceeds the limit of 5MB. Choose a smaller file.')));
        }
      }
      notifyListeners();
    }
    return Future.value();
  }

  void increment() {
    _counts++;
    notifyListeners();
  }

  void decrement() {
    if (_counts > 0) {
      _counts--;
      notifyListeners();
    }
  }

  //http://3.71.4.186:4002/api/v1/dashboard/Mob/ElementType/
  Future<List<Rows>> getElementById(String categoryId) async {
    final response = await api
        .get('http://18.159.111.224:4002/api/v1/dashboard/ElementType');
    //await api.get('api/v1/dashboard/Mob/ElementType/$categoryId');
    final item = response.data;
    List<Rows> list = [];
    if (response.statusCode == 200) {
      elementByIdModel = ElementByIdModel.fromJson(item);
      list.addAll(elementByIdModel.data!.rows ?? []);
    }
    notifyListeners();
    return list;
  }

  Future<List<ErrorData>> getErrorsList() async {
    final response = await api.get('api/v1/dashboard/Mob/ErrorType');
    final item = response.data;
    List<ErrorData> list = [];
    if (response.statusCode == 200) {
      errorTypeModel = ErrorTypeModel.fromJson(item);
      list.addAll(errorTypeModel.data ?? []);
    }
    notifyListeners();
    return list;
  }

  void clearTechnischeImage() {
    technischeImage = null;
    notifyListeners();
  }

  void clearLogBoekImage() {
    logBoekImage = null;
    notifyListeners();
  }
}

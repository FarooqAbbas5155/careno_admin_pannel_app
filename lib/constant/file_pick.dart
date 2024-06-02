import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class PickedImageData {
  final String name;
  final String path;
  final String fileType;

  PickedImageData(this.name, this.path, this.fileType);
}

class FilePick{
  static String getFileType(String fileName) {
    return fileName.split('.').last.toLowerCase();
  }
  Future<PickedImageData?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: false, // Ensure only one file is selected
          type: FileType.any
      );
      if (result == null || result.files.isEmpty) return null;
      if (result != null) {
        var files= result.files.single;
        final name = files.name;
        final path = files.path;
        final fileType = getFileType(name);
        return PickedImageData(name, path!, fileType);
      }
    } catch (e) {
      Get.snackbar("Alert", e.toString());
    }
  }
  Future<FilePickerResult?> pickMultiFile(List<String> type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: type,
    );
    var files = [];
    if (result != null) {
      PlatformFile file = result.files.first;
      print(file.name);
      print(file.bytes);
      print(files);
      print(file.size);
      print(file.extension);
      print(file.path);
    } else {
      Get.snackbar("Alert", "No File Pick");
    }
    return result;
  }
  Future<String> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile == null) {
        print("User canceled the picker");
        return "User canceled the picker"; // User canceled the picker
      }
      return pickedFile.path;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
  Future<List<File>> pickImages() async {
    List<File> _selectedFiles = [];

    try {

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
        readSequential: true
      );

      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
          _selectedFiles.addAll(files);
      }
    } catch (e) {
      print('Error picking images: $e');
    }
    return _selectedFiles;
  }
  Future<String> pickImageMobile() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile == null) {
        print("User canceled the picker");
        return "User canceled the picker"; // User canceled the picker
      }
      return pickedFile.path;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
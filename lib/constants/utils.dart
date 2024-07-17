import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
    ),
  );
}

Future<List<File>> pickImage() async {
  List<File> files = [];
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );
    if (result != null && result.files.isNotEmpty) {
      for (int i = 0; i < result.files.length; i++) {
        File f = File(result.files[i].path!);
        files.add(f);
      }
      return files;
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return files;
}

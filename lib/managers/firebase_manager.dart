import 'dart:io';
import 'package:flutter/material.dart';
import 'package:techhub/baseclass/custom.dart';
import 'package:techhub/models/models.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class FirebaseApi {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);
    // urls.sort((b, a) => a.substring(0, 1).compareTo(b.substring(0, 1)));
    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  static Future downloadFile(
    Reference ref,
    String folder,
    String userCourse,
  ) async {
    if (userCourse == folder) {
      final dir = await getExternalStorageDirectory();
      final filePath = join(dir!.path, '.$folder', ref.name);
      File(filePath).create(recursive: true).then((File file) async {
        await ref.writeToFile(file);
        toast('Downloaded', backgroundColor: Colors.green);
      });
    } else {
      toast('You can only download your course');
    }
  }
}

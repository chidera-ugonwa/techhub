import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SkillModelData {
  final String name;
  final String title;
  final Color bgColor;

  SkillModelData(this.name, this.bgColor, this.title);
}

class FirebaseFile {
  final Reference ref;
  final String name;
  final String url;
  FirebaseFile({
    required this.ref,
    required this.name,
    required this.url,
  });
}

class DownloadedFile {
  final String name;
  DownloadedFile({
    required this.name,
  });
}
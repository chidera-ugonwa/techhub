import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<List> getAllVideos(String target) async {
  List<FileSystemEntity> _folders;
  List<String> holder = [];
  try {
    final directory = await getExternalStorageDirectory();
    final dir = directory!.path;
    String folder = join(dir, '.$target');
    final myDir = Directory(folder);

    _folders = myDir.listSync(recursive: true, followLinks: false);
    for (FileSystemEntity i in _folders) {
      holder.add(i.path.split('/').last);
    }
    return holder;
  } on FileSystemException {
    // holder.sort((b, a) => a.substring(0, 1).compareTo(b.substring(0, 1)));
    return holder;
  }
}

Future<String?> getVideoDir(String target, String fileName) async {
  try {
    final directory = await getExternalStorageDirectory();
    final dir = directory!.path;
    String filePath = join(dir, '.$target', fileName);
    final file = File(filePath);
    final checkValidity = await file.exists();
    if (!checkValidity) return null;
    return file.path;
  } on FileSystemException {
    return null;
  }
}

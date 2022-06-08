import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techhub/managers/color_manager.dart';
import 'package:techhub/managers/file_manager.dart';
import 'package:techhub/managers/firebase_manager.dart';
import 'package:techhub/managers/video_manager.dart';

Future<bool?> toast(
  String message, {
  Color backgroundColor = Colors.red,
  Color textColor = Colors.white,
}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0);
}

class CustomWidget {
  static Widget roundImage({
    required double height,
    required String image,
    required BoxFit fit,
    Border? border,
    EdgeInsets? margin,
  }) =>
      Container(
        height: height,
        width: height,
        margin: margin,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorManager.white,
          border: border,
          image: DecorationImage(
            image: AssetImage(
              'assets/images/$image.png',
            ),
            fit: fit,
          ),
        ),
      );

  static Widget skillCard(
    String filename,
    String group,
    Color iconColor,
    Reference? fileRef,
    String folderName,
    String userCourse,
    BuildContext context, {
    bool download = true,
  }) {
    final name = filename.split('-')[0];
    final mainName = name.substring(1);
    final topic = filename.split('-')[1];
    final tutor = filename
        .split('-')[2]
        .substring(0, filename.split('-')[2].indexOf('.'));

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 8.0,
      ),
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainName,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Topic: $topic',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Group: $group',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Tutor: $tutor',
                ),
              ],
            ),
            download
                ? IconButton(
                    onPressed: () async {
                      FirebaseApi.downloadFile(
                          fileRef!, folderName, userCourse);
                    },
                    icon: Icon(
                      Icons.download_rounded,
                      color: iconColor,
                    ),
                  )
                : IconButton(
                    onPressed: () async {
                      final file = await getVideoDir(group, filename);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return VideoManager(file: file!);
                          },
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.play_arrow,
                      color: iconColor,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

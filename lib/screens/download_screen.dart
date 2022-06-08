import 'package:flutter/material.dart';
import 'package:techhub/baseclass/custom.dart';
import 'package:techhub/managers/color_manager.dart';
import 'package:techhub/managers/file_manager.dart';
import 'package:techhub/managers/preference_manager.dart';
import 'package:techhub/managers/text_manager.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({Key? key, required this.userPreference})
      : super(key: key);
  final UserPreference userPreference;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllVideos(userPreference.course.getValue()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else {
          List? result = snapshot.data as List;
          return result.isNotEmpty
              ? Scaffold(
                  appBar: AppBar(
                    title: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ColorManager.white,
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/${userPreference.course.getValue()}.png',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Downloaded Courses',
                          style: homeCardTextStyle(),
                        ),
                      ],
                    ),
                    centerTitle: true,
                    backgroundColor: ColorManager.transparent,
                    elevation: 0.0,
                    toolbarHeight: 80.0,
                  ),
                  backgroundColor: ColorManager.transparent,
                  body: ListView.builder(
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      return CustomWidget.skillCard(
                        result[index],
                        userPreference.course.getValue(),
                        ColorManager.appColorA,
                        null,
                        'folderName',
                        'userCourse',
                        context,
                        download: false,
                      );
                    },
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/notfound.png',
                        ),
                        Text(
                          'You don\'t have any downloads yet',
                          style: homeCardTextStyle(),
                        )
                      ],
                    ),
                  ),
                );
        }
      },
    );
  }
}

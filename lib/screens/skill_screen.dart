import 'package:flutter/material.dart';
import 'package:techhub/managers/color_manager.dart';
import 'package:techhub/managers/firebase_manager.dart';
import 'package:techhub/models/models.dart';
import 'package:techhub/managers/preference_manager.dart';
import 'package:techhub/baseclass/custom.dart';

class SkillScreen extends StatefulWidget {
  const SkillScreen({Key? key, required this.userPreference}) : super(key: key);
  final UserPreference userPreference;

  @override
  State<SkillScreen> createState() => _SkillScreenState();
}

class _SkillScreenState extends State<SkillScreen> {
  late Future<List<FirebaseFile>> futureFiles;

  Future<List<FirebaseFile>> getSkillList(String group) async {
    futureFiles = FirebaseApi.listAll('$group/');
    return futureFiles;
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as SkillModelData;

    return FutureBuilder<List<FirebaseFile>>(
      future: getSkillList(data.name),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  data.bgColor,
                  ColorManager.appColorB,
                ],
              ),
            ),
            child: const Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: ColorManager.white,
                  strokeWidth: 7.0,
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return SizedBox(
            child: Center(
              child: Text('${snapshot.error}'),
            ),
          );
        } else {
          final files = snapshot.data!;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  data.bgColor,
                  ColorManager.appColorB,
                ],
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 150.0,
                    elevation: 0.0,
                    backgroundColor: ColorManager.transparent,
                    pinned: false,
                    floating: true,
                    snap: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: data.name,
                        child: Image.asset(
                          'assets/images/${data.name}.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      final file = files[index];
                      return CustomWidget.skillCard(
                        file.name,
                        data.name,
                        data.bgColor,
                        file.ref,
                        data.name,
                        widget.userPreference.course.getValue(),
                        context,
                      );
                    }, childCount: files.length),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

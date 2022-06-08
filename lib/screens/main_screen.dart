import 'package:flutter/material.dart';
import 'package:techhub/managers/color_manager.dart';
import 'package:techhub/managers/text_manager.dart';
import 'package:techhub/models/models.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Learn\nA Skill\nToday !!',
                textAlign: TextAlign.left,
                style: frontInfoTextStyle(),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Expanded(
          flex: 2,
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            children: [
              homeCard(
                context,
                'Python',
                backgroundColor: ColorManager.pythonCardColor,
                image: 'python',
              ),
              homeCard(
                context,
                'Wordpress',
                backgroundColor: ColorManager.wordPressCardColor,
                image: 'wordpress',
              ),
              homeCard(
                context,
                'Front-End',
                backgroundColor: ColorManager.frontEndCardColor,
                image: 'frontend',
              ),
              homeCard(
                context,
                'Data science',
                backgroundColor: ColorManager.dataCardColor,
                image: 'data-science',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget homeCard(
  BuildContext context,
  String title, {
  required Color backgroundColor,
  required String image,
}) =>
    Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          '/skill_screen',
          arguments: SkillModelData(
            image,
            backgroundColor,
            title,
          ),
        ),
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: image,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 18,
                  ),
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/$image.png',
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                title,
                style: homeCardTextStyle(),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );

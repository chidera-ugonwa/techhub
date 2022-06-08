import 'package:flutter/material.dart';
import 'package:techhub/baseclass/app_dialog.dart';
import 'package:techhub/baseclass/custom.dart';
import 'package:techhub/managers/color_manager.dart';
import 'package:techhub/managers/preference_manager.dart';
import 'package:techhub/managers/text_manager.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key, required this.userPreference})
      : super(key: key);
  final UserPreference userPreference;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: Container(
            color: ColorManager.accountTopColor,
            height: screenHeight * 0.25,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    userPreference.name.getValue(),
                    style: accountScreenTextStyle(),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.25,
          right: 0,
          left: 0,
          child: Container(
            color: Colors.black12,
            height: screenHeight * 0.25,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userPreference.course.getValue(),
                        style: accountScreenTextStyle(),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () => userPreference.course.getValue() ==
                                'nothing yet'
                            ? UserChoice.chooseCourse(context, userPreference)
                            : toast('You have selected a course already'),
                        child: Icon(Icons.edit),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userPreference.name.getValue(),
                        style: accountScreenTextStyle(),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.25 - (screenHeight * 0.2) / 2,
          right: screenWidth * 0.45,
          left: 0,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              CustomWidget.roundImage(
                height: screenHeight * 0.2,
                image: 'profile',
                fit: BoxFit.cover,
                border: Border.all(
                  color: ColorManager.navColor,
                  width: 4.0,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0 + (screenWidth * 0.2) / 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.navColor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {},
                      child: Icon(Icons.edit),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: screenHeight * 0.50,
          right: 0,
          left: 0,
          child: SizedBox(
            height: screenHeight * 0.37,
            child: Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 1,
                    color: ColorManager.borderColor,
                    spreadRadius: 1,
                    blurStyle: BlurStyle.inner,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomWidget.roundImage(
                          height: 70,
                          image: 'profile',
                          fit: BoxFit.cover,
                        ),
                        CustomWidget.roundImage(
                          height: 30,
                          image: userPreference.course.getValue(),
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _dataDisplay(
                                icon: Icons.person,
                                data: userPreference.name.getValue(),
                                key: 'Name'),
                            _dataDisplay(
                                icon: Icons.mail,
                                data: userPreference.email.getValue(),
                                key: 'Email'),
                            _dataDisplay(
                                icon: Icons.school,
                                data: userPreference.course.getValue(),
                                key: 'Course'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

Widget _dataDisplay({
  required IconData icon,
  required String data,
  required String key,
}) =>
    Row(
      children: [
        Icon(icon),
        SizedBox(
          width: 15,
        ),
        Text(
          '$key: $data',
          style: accountScreenTextStyle(),
        ),
      ],
    );

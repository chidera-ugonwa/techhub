import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techhub/baseclass/custom.dart';
import 'package:techhub/managers/color_manager.dart';
import 'package:techhub/managers/preference_manager.dart';
import 'package:techhub/managers/text_manager.dart';
import 'package:techhub/screens/account_screen.dart';
import 'package:techhub/screens/download_screen.dart';
import 'package:techhub/screens/main_screen.dart';
import 'package:techhub/screens/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.userPreference}) : super(key: key);
  final UserPreference userPreference;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  late List<Widget> screens;
  bool showAppBar = true;

  @override
  void initState() {
    screens = [
      const MainScreen(),
      DownloadScreen(userPreference: widget.userPreference),
      const SettingScreen(),
      AccountScreen(userPreference: widget.userPreference),
    ];
    super.initState();
  }

  changeNavbar(int index) {
    setState(
      () {
        currentIndex = index;
        HapticFeedback.lightImpact();
        if (currentIndex == 0) {
          showAppBar = true;
        } else {
          showAppBar = false;
        }
      },
    );
  }

  Future<bool> _goBack() async {
    dynamic action = bool;

    if (showAppBar) {
      action = (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: ColorManager.appColorB,
              title: Text(
                'Do come back soon !',
                textAlign: TextAlign.center,
                style: homeCardTextStyle(),
              ),
              content: CustomWidget.roundImage(
                height: 70,
                image: 'icon',
                fit: BoxFit.contain,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              actions: <Widget>[
                TextButton.icon(
                  onPressed: () => Navigator.of(context).pop(true),
                  label: Text(
                    'Exit',
                    style: homeCardTextStyle(),
                  ),
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          )) ??
          false;
    } else {
      changeNavbar(0);
    }

    return action;
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _goBack,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorManager.appColorA,
              ColorManager.appColorB,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: ColorManager.transparent,
          appBar: showAppBar
              ? AppBar(
                  toolbarHeight: 70.0,
                  actions: [
                    GestureDetector(
                      onTap: () => changeNavbar(3),
                      child: CustomWidget.roundImage(
                        height: 100,
                        image: 'profile',
                        fit: BoxFit.contain,
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                      ),
                    )
                  ],
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                )
              : null,
          body: screens[currentIndex],
          bottomNavigationBar: Container(
            margin: EdgeInsets.all(displayWidth * .05),
            height: displayWidth * .155,
            decoration: BoxDecoration(
              color: ColorManager.white,
              boxShadow: [
                BoxShadow(
                  color: ColorManager.black.withOpacity(0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
              borderRadius: BorderRadius.circular(50),
            ),
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
              itemBuilder: (context, index) => InkWell(
                onTap: () => changeNavbar(index),
                splashColor: ColorManager.transparent,
                highlightColor: ColorManager.transparent,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: index == currentIndex
                          ? displayWidth * .32
                          : displayWidth * .18,
                      alignment: Alignment.center,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        height: index == currentIndex ? displayWidth * .12 : 0,
                        width: index == currentIndex ? displayWidth * .32 : 0,
                        decoration: BoxDecoration(
                          color: index == currentIndex
                              ? ColorManager.navColor.withOpacity(.2)
                              : ColorManager.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: index == currentIndex
                          ? displayWidth * .31
                          : displayWidth * .18,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex
                                    ? displayWidth * .13
                                    : 0,
                              ),
                              AnimatedOpacity(
                                opacity: index == currentIndex ? 1 : 0,
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: Text(
                                  index == currentIndex
                                      ? listOfStrings[index]
                                      : '',
                                  style: const TextStyle(
                                    color: ColorManager.navColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex
                                    ? displayWidth * .03
                                    : 20,
                              ),
                              Icon(
                                listOfIcons[index],
                                size: displayWidth * .076,
                                color: index == currentIndex
                                    ? Colors.blueAccent
                                    : Colors.black26,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.download,
    Icons.settings_rounded,
    Icons.person_rounded,
  ];

  List<String> listOfStrings = [
    'Home',
    'Download',
    'Settings',
    'Account',
  ];
}

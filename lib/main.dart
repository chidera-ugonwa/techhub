import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:techhub/managers/preference_manager.dart';
import 'package:techhub/screens/home_screen.dart';
import 'package:techhub/screens/skill_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final preferences = await StreamingSharedPreferences.instance;
  final userPreference = UserPreference(preferences);
  runApp(MyApp(userPreference: userPreference,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.userPreference}) : super(key: key);
  final UserPreference userPreference;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'OpenSans',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(userPreference: userPreference),
        '/skill_screen': (context) => SkillScreen(userPreference: userPreference),
      },
    );
  }
}

import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class UserPreference {
  UserPreference(StreamingSharedPreferences preferences)
      : name = preferences.getString('name', defaultValue: 'TechHub Student'),
        email =
            preferences.getString('email', defaultValue: 'techhub@ieee.com'),
        course = preferences.getString('course', defaultValue: 'nothing yet');

  final Preference<String> name;
  final Preference<String> email;
  final Preference<String> course;
}

import 'package:flutter/material.dart';
import 'package:techhub/managers/preference_manager.dart';

enum courseChoice { python, wordpress, data, frontend, nothing }

class CourseList extends StatefulWidget {
  const CourseList({Key? key, required this.userPreference}) : super(key: key);

  final UserPreference userPreference;

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  courseChoice? _course;

  _performAction(courseChoice? value, String name) {
    setState(
      () {
        _course = value;
      },
    );
    widget.userPreference.course.setValue(name);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.userPreference.course.getValue()) {
      case 'python':
        _course = courseChoice.python;
        break;
      case 'frontend':
        _course = courseChoice.frontend;
        break;
      case 'data-science':
        _course = courseChoice.data;
        break;
      case 'wordpress':
        _course = courseChoice.wordpress;
        break;
      default:
        _course = courseChoice.nothing;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Radio(
            value: courseChoice.python,
            groupValue: _course,
            onChanged: (courseChoice? value) => _performAction(value, 'python'),
          ),
          title: Text('Python'),
          onTap: () => _performAction(courseChoice.python, 'python'),
        ),
        ListTile(
          leading: Radio(
            value: courseChoice.wordpress,
            groupValue: _course,
            onChanged: (courseChoice? value) =>
                _performAction(value, 'wordpress'),
          ),
          onTap: () => _performAction(courseChoice.wordpress, 'wordpress'),
          title: Text('Wordpress'),
        ),
        ListTile(
          leading: Radio(
            value: courseChoice.frontend,
            groupValue: _course,
            onChanged: (courseChoice? value) =>
                _performAction(value, 'frontend'),
          ),
          onTap: () => _performAction(courseChoice.frontend, 'frontend'),
          title: Text('Front-end'),
        ),
        ListTile(
          leading: Radio(
            value: courseChoice.data,
            groupValue: _course,
            onChanged: (courseChoice? value) =>
                _performAction(value, 'data-science'),
          ),
          onTap: () => _performAction(courseChoice.data, 'data-science'),
          title: Text('Data-science'),
        ),
      ],
    );
  }
}

class UserChoice {
  static chooseCourse(
    BuildContext context,
    UserPreference userPreference,
  ) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Choose a course !'),
        content: CourseList(userPreference: userPreference),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiba/models/db_model.dart';
import 'package:tiba/models/tiba_model.dart';
import 'package:tiba/server/database_api.dart';
import 'package:tiba/ui_screens/admin_widgets/m_results.dart';
import 'package:tiba/ui_screens/admin_widgets/m_schedule.dart';
import 'package:tiba/ui_screens/admin_widgets/m_students.dart';

class xColors {
  static const Color mainColor = Color(0xff1f4399);
  static const Color pinkColor = Color(0xffF4DEFD);
  static const Color accentColor = Color(0xff0F2F44);
  static const Color greenColor = Color(0xff84ae1a);
  static const Color btnColor = Color(0xff373951);
  static const Color offWhite = Color(0xffF1F1F1);
  static const Color textColor = Color(0xff373951);
  static const Color backGroundColor = Color(0xffd8dbff);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color hintColor = Colors.black45;

  static MaterialStateProperty<Color> materialColor(var color) {
    return MaterialStateProperty.all<Color>(color);
  }

  static MaterialStateProperty<OutlinedBorder> materialShape(var shape) {
    return MaterialStateProperty.all<OutlinedBorder>(shape);
  }
}

class EnStrings {
  String appName = "BookingApp";
}

class MyTheme {
  ThemeData buildLightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
        textTheme: TextTheme(
          headline6: TextStyle(
            fontWeight: FontWeight.w200,
            color: xColors.mainColor,
          ),
          headline1: TextStyle(
            fontWeight: FontWeight.w400,
            color: xColors.mainColor,
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.w400,
            color: xColors.mainColor,
          ),
          headline3: TextStyle(
            fontWeight: FontWeight.w400,
            color: xColors.mainColor,
          ),
          headline4: TextStyle(
            fontWeight: FontWeight.w400,
            color: xColors.mainColor,
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.w400,
            color: xColors.mainColor,
          ),
          bodyText1: TextStyle(
            fontWeight: FontWeight.w400,
            color: xColors.textColor,
          ),
          bodyText2: TextStyle(
            fontWeight: FontWeight.w400,
            color: xColors.textColor,
          ),
          button: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          subtitle1: TextStyle(
            fontWeight: FontWeight.w400,
            color: xColors.textColor,
          ),
          subtitle2: TextStyle(
            fontWeight: FontWeight.w400,
            color: xColors.textColor,
          ),
        ),
        primaryColor: xColors.mainColor,
        accentColor: xColors.accentColor,
        scaffoldBackgroundColor: xColors.white,
        cardColor: Colors.white,
        textSelectionColor: Colors.amberAccent,
        errorColor: xColors.greenColor,
        textSelectionHandleColor: Colors.grey,
        appBarTheme: _appBarTheme());
  }

  AppBarTheme _appBarTheme() {
    return AppBarTheme(
      elevation: 0.0,
      textTheme: TextTheme(
          headline6: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: xColors.white,
      )),
      color: xColors.mainColor,
      iconTheme: IconThemeData(
        color: xColors.white,
      ),
    );
  }
}

enum AdminPages { student, schedule, result }
enum StudentPages { my_schedule,  my_result }

Widget openAdminPage(
    {AdminPages page, int level, int department, int semester , int exam, TibaModel tibaModel}) {
  switch (page) {
    case AdminPages.student:
      return StreamProvider<List<UserModel>>.value(
          initialData: null,
          value: DatabaseService().getLiveUsers(department, level),
          child: ManageStudents(department: department, level: level));
    case AdminPages.schedule:
      return ManageSchedule(
        department: department,
        level: level,
        semester: semester,
        exam : exam
      );
    case AdminPages.result:
      return StreamBuilder<List<UserModel>>(
          stream: DatabaseService().getLiveUsers(department, level),
          builder: (context, snapshot) {
            List<UserModel> userList = snapshot.data;
            return userList != null
                ? ManageResults(
                    semester: semester,
                    level: level,
                    department: department,
                    data: userList ,tibaModel: tibaModel,)
                : SizedBox();
          });
  }
}


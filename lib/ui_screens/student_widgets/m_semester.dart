import 'package:flutter/material.dart';
import 'package:tiba/models/db_model.dart';
import 'package:tiba/models/tiba_model.dart';
import 'package:tiba/server/database_api.dart';
import 'package:tiba/ui_screens/student_widgets/m_results.dart';
import 'package:tiba/ui_screens/student_widgets/m_schedule_type.dart';
import 'package:tiba/ui_widget/home_widgets/admin_widgets/admin_card.dart';
import 'package:tiba/utils/dimensions.dart';
import 'package:tiba/utils/utils.dart';

class ManageSemester extends StatefulWidget {
  StudentPages page;

  ManageSemester({Key key, @required this.page}) : super(key: key);

  @override
  _ManageSemesterState createState() => _ManageSemesterState();
}

class _ManageSemesterState extends State<ManageSemester> {
  TibaModel data;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    data = await DatabaseService().getTibaData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: xColors.mainColor,
          title: Text(
            'اختر الترم',
          )),
      body: data != null && data.semesters != null
          ? StreamBuilder<UserModel>(
              stream: DatabaseService().getUserById,
              builder: (context, snapshot) {
                UserModel user = snapshot.data;
                return user!=null ?ListView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: Responsive.width(2, context),
                      vertical: Responsive.height(1.5, context)),
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return AdminCard(
                        title: '${data.semesters[index].semesterName}',
                        open: widget.page == StudentPages.my_schedule
                            ? ManageScheduleType(
                                department: user.department,
                                level: user.level,
                                semester: data.semesters[index].semesterType,
                                tibaModel: data)
                            : StreamBuilder<UserScore>(
                                stream: DatabaseService().getUserScore(user.id),
                                builder: (context, snapshot) {
                                  UserScore score = snapshot.data;
                                  print(score);
                                  return MyResults(
                                    department: user.department,
                                    level: user.level,
                                    oldScore: score,
                                    semester: data.semesters[index].semesterType,
                                    tibaModel: data,
                                    user: user,
                                    listOfSubjects: data
                                        .semesters[data.semesters[index].semesterType - 1]
                                        .levels[user.level - 1]
                                        .department[user.department - 1]
                                        .subjects,
                                  );
                                }));
                  },
                  itemCount: data.semesters.length,
                ):SizedBox();
              })
          : SizedBox(),
    );
  }
}

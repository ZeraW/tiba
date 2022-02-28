import 'package:flutter/material.dart';
import 'package:tiba/models/tiba_model.dart';
import 'package:tiba/server/database_api.dart';
import 'package:tiba/ui_screens/admin_widgets/m_departments.dart';
import 'package:tiba/ui_widget/home_widgets/admin_widgets/admin_card.dart';
import 'package:tiba/utils/dimensions.dart';
import 'package:tiba/utils/utils.dart';

import 'm_levels.dart';

class ManageSemester extends StatefulWidget {
  AdminPages page;

   ManageSemester({Key key, this.page}) : super(key: key);

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
          ? ListView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.width(2, context),
                  vertical: Responsive.height(1.5, context)),
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return AdminCard(
                  title: '${data.semesters[index].semesterName}',
                  open: ManageDepartments(page: widget.page,semester: data.semesters[index].semesterType ,),
                );
              },
              itemCount: data.semesters.length,
            )
          : SizedBox(),
    );
  }
}

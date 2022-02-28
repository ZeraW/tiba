import 'package:flutter/material.dart';
import 'package:tiba/ui_screens/student_widgets/m_semester.dart';
import 'package:tiba/ui_widget/home_widgets/admin_widgets/admin_card.dart';
import 'package:tiba/utils/dimensions.dart';
import 'package:tiba/utils/utils.dart';

import '../../models/db_model.dart';

class StudentScreen extends StatefulWidget {

  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.width(2,context)),
      child: Column(
        children: [
          SizedBox(height: Responsive.height(1,context)),
          AdminCard(
              title: 'الجدول',
              open: ManageSemester(page: StudentPages.my_schedule,)),
          AdminCard(
              title: 'درجاتي',
              open:  ManageSemester(page: StudentPages.my_result,)),
        ],
      ),
    );
  }
}

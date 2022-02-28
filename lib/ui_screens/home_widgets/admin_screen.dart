import 'package:flutter/material.dart';
import 'package:tiba/ui_screens/admin_widgets/m_departments.dart';
import 'package:tiba/ui_screens/admin_widgets/m_semester.dart';
import 'package:tiba/ui_widget/home_widgets/admin_widgets/admin_card.dart';
import 'package:tiba/utils/dimensions.dart';
import 'package:tiba/utils/utils.dart';

import '../../models/db_model.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.width(2,context)),
      child: Column(
        children: [
          SizedBox(height: Responsive.height(1,context)),
          AdminCard(
              title: 'طلبة المعهد',
              open: ManageDepartments(page: AdminPages.student,)),
          AdminCard(
              title: 'الجدول',
              open: ManageSemester(page:AdminPages.schedule)),
          AdminCard(
              title: 'اضافة الدرجات',
              open:  ManageSemester(page:AdminPages.result)),
        ],
      ),
    );
  }
}

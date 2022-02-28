import 'package:flutter/material.dart';
import 'package:tiba/models/tiba_model.dart';
import 'package:tiba/server/database_api.dart';
import 'package:tiba/ui_widget/home_widgets/admin_widgets/admin_card.dart';
import 'package:tiba/utils/dimensions.dart';
import 'package:tiba/utils/utils.dart';

import 'm_levels.dart';
class ManageScheduleType extends StatelessWidget {
  TibaModel tibaModel;

  AdminPages page;
  int semester,department,level;

  ManageScheduleType({Key key, this.page ,this.semester,this.department,this.level,this.tibaModel}) : super(key: key);

  List<String> cs= ['محاضرات','ميدتيرم','فاينال'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: xColors.mainColor,
          title: Text(
            'اختر نوع الجدول',
          )),
      body: ListView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.width(2, context),
                  vertical: Responsive.height(1.5, context)),
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return AdminCard(
                  title: cs[index],
                  open: openAdminPage(
                      page: page,
                      department: department,
                      exam: index==0 ? null:index,
                      level: level,
                      semester: semester, tibaModel: tibaModel),
                );
              },
              itemCount: cs.length,
            ),
    );
  }
}

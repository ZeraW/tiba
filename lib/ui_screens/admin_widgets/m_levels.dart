import 'package:flutter/material.dart';
import 'package:tiba/models/tiba_model.dart';
import 'package:tiba/server/database_api.dart';
import 'package:tiba/ui_widget/home_widgets/admin_widgets/admin_card.dart';
import 'package:tiba/utils/dimensions.dart';
import 'package:tiba/utils/utils.dart';

import 'm_schedule_type.dart';

class ManageLevels extends StatefulWidget {
  AdminPages page;
  int department, semester;

  ManageLevels({Key key, this.page, this.department, this.semester})
      : super(key: key);

  @override
  _ManageLevelsState createState() => _ManageLevelsState();
}

class _ManageLevelsState extends State<ManageLevels> {
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
            'اختر المستوي',
          )),
      body: data != null && data.levelsNames != null
          ? ListView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.width(2, context),
                  vertical: Responsive.height(1.5, context)),
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return AdminCard2(
                  title: 'المستوي ${data.levelsNames[index].level}',
                  open: () => Navigator.push(context, MaterialPageRoute(
                          builder: (_) =>
                              widget.page!= AdminPages.schedule?
                              openAdminPage(
                              page: widget.page,
                              department: widget.department,
                              level: data.levelsNames[index].id,
                              semester: widget.semester, tibaModel: data):ManageScheduleType(page: widget.page,
                                  department: widget.department,
                                  level: data.levelsNames[index].id,
                                  semester: widget.semester, tibaModel: data)
                  )),
                );
              },
              itemCount: data.levelsNames.length,
            )
          : SizedBox(),
    );
  }
}

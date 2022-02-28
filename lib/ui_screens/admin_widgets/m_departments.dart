import 'package:flutter/material.dart';
import 'package:tiba/models/tiba_model.dart';
import 'package:tiba/server/database_api.dart';
import 'package:tiba/ui_widget/home_widgets/admin_widgets/admin_card.dart';
import 'package:tiba/utils/dimensions.dart';
import 'package:tiba/utils/utils.dart';

import 'm_levels.dart';

class ManageDepartments extends StatefulWidget {
  AdminPages page;
  int semester;

   ManageDepartments({Key key, this.page ,this.semester}) : super(key: key);

  @override
  _ManageDepartmentsState createState() => _ManageDepartmentsState();
}

class _ManageDepartmentsState extends State<ManageDepartments> {
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
            'اختر القسم',
          )),
      body: data != null && data.departmentsNames != null
          ? ListView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.width(2, context),
                  vertical: Responsive.height(1.5, context)),
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return AdminCard(
                  title: data.departmentsNames[index].department,
                  open: ManageLevels(page: widget.page,department:data.departmentsNames[index].id ,semester: widget.semester,),
                );
              },
              itemCount: data.departmentsNames.length,
            )
          : SizedBox(),
    );
  }
}

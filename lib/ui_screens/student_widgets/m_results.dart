import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:tiba/models/db_model.dart';
import 'package:tiba/models/tiba_model.dart';
import 'package:tiba/server/database_api.dart';
import 'package:tiba/ui_widget/home_widgets/admin_widgets/admin_card.dart';
import 'package:tiba/ui_widget/textfield_widget.dart';
import 'package:tiba/utils/dimensions.dart';
import 'package:tiba/utils/utils.dart';

class MyResults extends StatefulWidget {
  int department, level, semester;
  UserModel user;
  TibaModel tibaModel;
  List<String> listOfSubjects;
  int subjectNum;

  UserScore oldScore;

  MyResults(
      {Key key,
        this.department,
        this.level,
        this.semester,
        this.user,this.oldScore,
        this.subjectNum,
        this.listOfSubjects,
        this.tibaModel})
      : super(key: key);

  @override
  _MyResultsState createState() => _MyResultsState();
}

class _MyResultsState extends State<MyResults> {
  List<TextEditingController> controllers;
  Map<String, int> result = {};

  @override
  void initState() {
    super.initState();
    result = widget.oldScore.getMap('y${widget.level}t${widget.semester}');
    controllers = List.generate(
        widget.listOfSubjects.length, (i) => TextEditingController(text: result[widget.listOfSubjects[i]] ==null ? '':result[widget.listOfSubjects[i]].toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: xColors.mainColor,
          title: Text(
            '${widget.user.name}',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Responsive.width(5, context)),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 1,
                            child: Text('${widget.listOfSubjects[index]}')),
                        SizedBox(
                          width: 25,
                        ),
                        Flexible(
                          flex: 2,
                          child: controllers[index] != null
                              ? CleanTextField(
                            controller: controllers[index],
                            hint: 'الدرجة',
                            enabled: false,
                            keyType: TextInputType.numberWithOptions(
                                signed: false),
                            maxLength: 3,
                          )
                              : SizedBox(),
                        )
                      ],
                    ),
                  );
                },
                itemCount: widget.listOfSubjects.length,
                shrinkWrap: true,
              ),
            ),
            SizedBox(
              height: Responsive.height(1.0, context),
            ),
            SizedBox(
              height: Responsive.height(1.0, context),
            ),
          ],
        ),
      ),
    );
  }
}





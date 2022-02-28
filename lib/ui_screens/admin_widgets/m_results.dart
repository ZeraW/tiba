import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:tiba/models/db_model.dart';
import 'package:tiba/models/tiba_model.dart';
import 'package:tiba/server/database_api.dart';
import 'package:tiba/ui_widget/home_widgets/admin_widgets/admin_card.dart';
import 'package:tiba/ui_widget/textfield_widget.dart';
import 'package:tiba/utils/dimensions.dart';
import 'package:tiba/utils/utils.dart';

class ManageResults extends StatelessWidget {
  int department, level, semester;
  List<UserModel> data;
  TibaModel tibaModel;

  ManageResults(
      {Key key,
      this.department,
      this.level,
      this.semester,
      this.data,
      this.tibaModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: xColors.mainColor,
          title: Text(
            'الطلاب',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Responsive.width(5, context)),
          )),
      body: data != null
          ? ListView(
              children: [
                Wrap(
                    children: data
                        .map((item) => UsersCard(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            StreamBuilder<UserScore>(
                                                stream: DatabaseService().getUserScore(item.id),
                                                builder: (context, snapshot) {
                                                  UserScore score = snapshot.data;
                                                  print(score);
                                                  return score!=null && score.getScore('y${level}t$semester')!=null?
                                                  EditResults(
                                                    tibaModel: tibaModel,
                                                    department: department,
                                                    oldScore : score,
                                                    level: level,
                                                    semester: semester,
                                                    listOfSubjects: tibaModel
                                                        .semesters[semester - 1]
                                                        .levels[level - 1]
                                                        .department[department - 1]
                                                        .subjects,
                                                    user: item,
                                                  ) :
                                                  AddResults(
                                                    tibaModel: tibaModel,
                                                    department: department,
                                                    level: level,
                                                    semester: semester,
                                                    listOfSubjects: tibaModel
                                                        .semesters[semester - 1]
                                                        .levels[level - 1]
                                                        .department[department - 1]
                                                        .subjects,
                                                    user: item,
                                                  );
                                              }
                                            )));
                              },
                              name: '${item.name}',
                              userId: item.userId,
                              password: item.password,
                            ))
                        .toList()
                        .cast<Widget>()),
              ],
            )
          : Center(child: Text('لا يوجد طلاب')),
    );
  }
}

class AddResults extends StatefulWidget {
  int department, level, semester;
  UserModel user;
  TibaModel tibaModel;
  List<String> listOfSubjects;
  int subjectNum;
  AddResults(
      {Key key,
      this.department,
      this.level,
      this.semester,
      this.user,
      this.subjectNum,
      this.listOfSubjects,
      this.tibaModel})
      : super(key: key);

  @override
  _AddResultsState createState() => _AddResultsState();
}

class _AddResultsState extends State<AddResults> {
  List<TextEditingController> controllers;
  Map<String, int> result = {};

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
        widget.listOfSubjects.length, (i) => TextEditingController());
    result = Map.fromIterable(widget.listOfSubjects,
        key: (v) => v, value: (v) => 0);
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
                                  hint: 'اضف الدرجة',
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
            Center(
              child: Container(
                margin: EdgeInsets.only(top: Responsive.height(2, context)),
                height: Responsive.height(7.0, context),
                width: Responsive.width(65, context),
                child: ElevatedButton(
                  onPressed: () async {
                    int totalScore =  0;
                    for (int i = 0 ; i<controllers.length ; i++) {
                      int value = 0 ;
                      if (controllers[i].text != null && controllers[i].text.isNotEmpty) {
                        value = int.parse(controllers[i].text);
                      }
                      result.update(widget.listOfSubjects[i], (existingValue) => value, ifAbsent: () => value,);
                      totalScore = totalScore + value ;
                    }
                    print('$totalScore');
                    await DatabaseService().updateScore(title:'y${widget.level}t${widget.semester}',
                        uid: widget.user.id,scores: result,totalScore: totalScore );
                  },
                  style: ButtonStyle(
                      backgroundColor: xColors.materialColor(xColors.mainColor),
                      shape: xColors.materialShape(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)))),
                  child: Text(
                    "حفظ البيانات",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.width(4.0, context),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
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


class EditResults extends StatefulWidget {
  int department, level, semester;
  UserModel user;
  TibaModel tibaModel;
  List<String> listOfSubjects;
  int subjectNum;

  UserScore oldScore;

  EditResults(
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
  _EditResultsState createState() => _EditResultsState();
}

class _EditResultsState extends State<EditResults> {
  List<TextEditingController> controllers;
  Map<String, int> result = {};

  @override
  void initState() {
    super.initState();
    result = widget.oldScore.getMap('y${widget.level}t${widget.semester}');
    controllers = List.generate(
        widget.listOfSubjects.length, (i) => TextEditingController(text: result[widget.listOfSubjects[i]].toString()));
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
                            hint: 'اضف الدرجة',
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
            Center(
              child: Container(
                margin: EdgeInsets.only(top: Responsive.height(2, context)),
                height: Responsive.height(7.0, context),
                width: Responsive.width(65, context),
                child: ElevatedButton(
                  onPressed: () async {
                    int totalScore =  0;
                    for (int i = 0 ; i<controllers.length ; i++) {
                      int value = 0 ;
                      if (controllers[i].text != null && controllers[i].text.isNotEmpty) {
                        value = int.parse(controllers[i].text);
                      }
                      result.update(widget.listOfSubjects[i], (existingValue) => value, ifAbsent: () => value,);
                      totalScore = totalScore + value ;
                    }
                    print('$totalScore');
                    await DatabaseService().updateScore(title:'y${widget.level}t${widget.semester}',
                        uid: widget.user.id,scores: result,totalScore: totalScore );
                  },
                  style: ButtonStyle(
                      backgroundColor: xColors.materialColor(xColors.mainColor),
                      shape: xColors.materialShape(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)))),
                  child: Text(
                    "حفظ البيانات",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.width(4.0, context),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
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





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiba/models/db_model.dart';
import 'package:tiba/models/tiba_model.dart';
import 'package:tiba/server/auth.dart';
import 'package:tiba/server/database_api.dart';
import 'package:tiba/ui_widget/textfield_widget.dart';
import 'package:tiba/utils/dimensions.dart';
import 'package:tiba/utils/utils.dart';

class AdminProfileScreen extends StatefulWidget {
  UserModel user;

  AdminProfileScreen(this.user);

  @override
  _AdminProfileScreenState createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _userIdController = new TextEditingController();
  TextEditingController _nationalIdController = new TextEditingController();
  bool isEnabled = false;


  @override
  Widget build(BuildContext context) {



      _nameController.text = widget.user.name;
      _userIdController.text = widget.user.userId;
      _passwordController.text = widget.user.password;



    return widget.user != null
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.width(10,context),),
            child: ListView(
              children: [

                SizedBox(
                  height: Responsive.height(3.0,context),
                ),

                TextFormBuilder(
                  hint: "الاسم",
                  enabled: isEnabled,
                  controller: _nameController,
                ),
                SizedBox(
                  height: Responsive.height(3.0,context),
                ),
                TextFormBuilder(
                  hint: "كود المستخدم",
                  enabled: false,
                  controller: _userIdController,
                ),
                SizedBox(
                  height: Responsive.height(3.0,context),
                ),

                TextFormBuilder(
                  hint: "كلمة المرور",
                  keyType: TextInputType.text,
                  isPassword: false,
                  enabled: isEnabled,
                  controller: _passwordController,
                  errorText: '',
                ),
                SizedBox(
                  height: Responsive.height(3.0,context),
                ),

                Container(
                  margin: EdgeInsets.only(top: Responsive.height(2,context)),
                  height: Responsive.height(7.0,context),
                  width: Responsive.width(65,context),
                  child: ElevatedButton(
                    onPressed: () async {
                      await AuthService().signOut();
                    },
                    style: ButtonStyle(
                        backgroundColor: xColors.materialColor(Color(0xffc13001)),
                        shape: xColors.materialShape(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)))),
                    child: Text(
                      "تسجيل الخروج",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Responsive.width(4.0,context),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

              ],
            ),
          )
        : Center(child: Text('جاري التحميل ...'));
  }


}


class StudentProfileScreen extends StatefulWidget {
  UserModel user;

  StudentProfileScreen(this.user);

  @override
  _StudentProfileScreenState createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _lvlController = new TextEditingController();
  TextEditingController _userIdController = new TextEditingController();
  TextEditingController _departmentController = new TextEditingController();
  bool isEnabled = false;
  TibaModel data;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  void getData() async {

    data = await DatabaseService().getTibaData().then((value) {

      _nameController.text = widget.user.name;
      _userIdController.text = widget.user.userId;
      _passwordController.text = widget.user.password;
      _lvlController.text =value.levelsNames.firstWhere((element) => element.id == widget.user.level).level;
      _departmentController.text =value.departmentsNames.firstWhere((element) => element.id == widget.user.department).department;

      return value;
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {












    return widget.user != null && data!= null
        ? Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.width(10,context),),
      child: ListView(
        children: [

          SizedBox(
            height: Responsive.height(3.0,context),
          ),

          TextFormBuilder(
            hint: "الاسم",
            enabled: isEnabled,
            controller: _nameController,
          ),
          SizedBox(
            height: Responsive.height(3.0,context),
          ),
          TextFormBuilder(
            hint: "كود المستخدم",
            enabled: false,
            controller: _userIdController,
          ),
          SizedBox(
            height: Responsive.height(3.0,context),
          ),

          TextFormBuilder(
            hint: "القسم",
            enabled: false,
            controller: _departmentController,
          ),
          SizedBox(
            height: Responsive.height(3.0,context),
          ),
          TextFormBuilder(
            hint: "المستوي",
            enabled: false,
            controller: _lvlController,
          ),
          SizedBox(
            height: Responsive.height(3.0,context),
          ),

          TextFormBuilder(
            hint: "كلمة المرور",
            keyType: TextInputType.text,
            isPassword: false,
            enabled: isEnabled,
            controller: _passwordController,
            errorText: '',
          ),
          SizedBox(
            height: Responsive.height(3.0,context),
          ),

          Container(
            margin: EdgeInsets.only(top: Responsive.height(2,context)),
            height: Responsive.height(7.0,context),
            width: Responsive.width(65,context),
            child: ElevatedButton(
              onPressed: () async {
                await AuthService().signOut();
              },
              style: ButtonStyle(
                  backgroundColor: xColors.materialColor(Color(0xffc13001)),
                  shape: xColors.materialShape(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)))),
              child: Text(
                "تسجيل الخروج",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Responsive.width(4.0,context),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),

        ],
      ),
    )
        : Center(child: Text('جاري التحميل ...'));
  }


}

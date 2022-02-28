import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiba/models/db_model.dart';
import 'package:tiba/server/auth.dart';
import 'package:tiba/ui_widget/home_widgets/admin_widgets/admin_card.dart';
import 'package:tiba/ui_widget/textfield_widget.dart';
import 'package:tiba/utils/dimensions.dart';
import 'package:tiba/utils/utils.dart';

class ManageStudents extends StatelessWidget {
   int department, level;

  ManageStudents({Key key, this.department, this.level}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     final mList = Provider.of<List<UserModel>>(context);

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
                 fontSize: Responsive.width(5,context)),
           )),
       body: mList != null
           ? ListView(
         children: [
           Wrap(
             children: mList
                 .map((item) => UsersCard(
               name: '${item.name}',
               userId: item.userId,
               password: item.password,
             ))
                 .toList()
                 .cast<Widget>(),
           ),
         ],
       )
           : Center(child: Text('لا يوجد طلاب')),
       floatingActionButton: FloatingActionButton(
         heroTag: 'addAccount',
         onPressed: () => _increment(
             context: context, nextId: mList != null ? mList.length + 1 : 0),
         tooltip: 'اضف طالب جديد',
         backgroundColor: xColors.mainColor,
         child: Icon(
           Icons.add,
         ),
       ),
     );
   }
   void _increment({ BuildContext context,  int nextId}) {
     Navigator.push(
         context,
         MaterialPageRoute(
             builder: (_) => CreateUserAccountScreen(level: level,department: department,)));
   }

}



class CreateUserAccountScreen extends StatefulWidget {
  int department,level;

  CreateUserAccountScreen({this.level,this.department});

  @override
  _CreateUserAccountScreenState createState() => _CreateUserAccountScreenState();
}

class _CreateUserAccountScreenState extends State<CreateUserAccountScreen> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _repasswordController = new TextEditingController();
  TextEditingController _userIdController = new TextEditingController();

  String _nameError = "";
  String _userIdError = "";
  String _passError = "";
  String _rePassError = "";


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: xColors.mainColor,
          title: Text(
            "تسجيل طالب جديد",
          )),
      body: Container(
        height: Responsive.height(100,context),
        padding: EdgeInsets.symmetric(
            vertical: Responsive.height(2,context),
            horizontal: Responsive.width(4,context)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/logo_side.png",
                ),
              ),
              SizedBox(
                height: Responsive.height(3.5,context),
              ),
              TextFormBuilder(
                hint: "اسم الطالب",
                controller: _nameController,
                errorText: _nameError,
              ),
              SizedBox(
                height: Responsive.height(3.0,context),
              ),
              TextFormBuilder(
                hint: "كود الطالب",
                keyType: TextInputType.emailAddress,
                controller: _userIdController,
                errorText: _userIdError,
              ),
              SizedBox(
                height: Responsive.height(3.0,context),
              ),
              TextFormBuilder(
                hint: "كلمة المرور",
                isPassword: true,
                controller: _passwordController,
                errorText: _passError,
              ),
              SizedBox(
                height: Responsive.height(3.0,context),
              ),
              TextFormBuilder(
                hint: "تأكيد كلمة المرور",
                isPassword: true,
                controller: _repasswordController,
                errorText: _rePassError,
              ),
              SizedBox(
                height: Responsive.height(3.0,context),
              ),
              SizedBox(
                height: Responsive.height(7.0,context),
                child: RaisedButton(
                  onPressed: () {
                    _reg(context);
                  },
                  color: xColors.mainColor,
                  child: Text(
                    "تسجيل طالب جديد",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.width(4.0,context),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _reg(BuildContext context) async {
    String firstName = _nameController.text;
    String userId = _userIdController.text.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    String password = _passwordController.text;
    String passwordConfirm = _repasswordController.text;

    if (firstName == null || firstName.isEmpty) {
      _nameError = "ادخل اسم الطالب";
      setState(() {

      });
    } else if (userId == null || userId.isEmpty) {
      clear();
      _userIdError = "ادخل كود الطالب";
    } else if (password == null || password.isEmpty) {
      clear();
      _passError = "ادخل كلمة المرور";
    } else if (passwordConfirm == null || passwordConfirm.isEmpty) {
      clear();
      _rePassError = "ادخل تأكيد كلمة المرور";
    } else if (password != passwordConfirm) {
      clear();
      _passError = "كلمات المرور غير متطابقة";
      _rePassError = "كلمات المرور غير متطابقة";
    }else {
      clear();
      UserModel newUser = UserModel(
          name: firstName,
          password: password,
          userId: userId,
          department: widget.department,
          level: widget.level,
          type: 'student');
      await AuthService().registerWithoutLogin(
          context: context, newUser: newUser);
    }
  }

  void clear() {
    setState(() {
      _nameError = "";
      _passError = "";
      _rePassError = "";
    });
  }
}



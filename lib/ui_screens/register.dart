
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiba/models/db_model.dart';
import 'package:tiba/server/auth.dart';
import 'package:tiba/server/auth_manage.dart';
import 'package:tiba/ui_widget/textfield_widget.dart';
import 'package:tiba/utils/dimensions.dart';
import 'package:tiba/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  String type;

  RegisterScreen({this.type});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
          leading: GestureDetector(
            onTap: () => Provider.of<AuthManage>(context, listen: false)
                .toggleWidgets(currentPage: 1, type: widget.type),
            child: Icon(
              Icons.chevron_left,
              size: Responsive.width(7.0,context),
            ),
          ),
          title: Text(
            "تسجيل مستخدم جديد",
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
                hint: "اسم المستخدم",
                controller: _nameController,
                errorText: _nameError,
              ),
              SizedBox(
                height: Responsive.height(3.0,context),
              ),

              TextFormBuilder(
                hint: "كود المستخدم",
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
                    "تسجيل مستخدم جديد",
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
      _nameError = "ادخل اسم المستخدم";
      setState(() {

      });
    } else if (userId == null || userId.isEmpty) {
      clear();
      _userIdError = "ادخل كود المستخدم";
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
          type: widget.type);
      await AuthService().registerWithEmailAndPassword(
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

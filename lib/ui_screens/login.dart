
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiba/server/auth.dart';
import 'package:tiba/server/auth_manage.dart';
import 'package:tiba/ui_widget/textfield_widget.dart';
import 'package:tiba/utils/dimensions.dart';
import 'package:tiba/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  String type;

  LoginScreen({this.type});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _mailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  String _emailError = "";
  String _passwordError = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal:  Responsive.width(6.0,context)),
          child: ListView(
            children: [
              SizedBox(
                height: Responsive.height(6,context),
              ),
              Center(
                child: Image.asset(
                  "assets/images/logo_side.png",
                ),
              ),
              SizedBox(
                height: Responsive.height(12.0,context),
              ),
              TextFormBuilder(
                controller: _mailController,
                hint: "كود المستخدم",
                keyType: TextInputType.visiblePassword,
                errorText: _emailError,
              ),
              SizedBox(
                height: Responsive.height(3.0,context),
              ),
              TextFormBuilder(
                controller: _passwordController,
                hint: "كلمة السر",
                keyType: TextInputType.visiblePassword,
                isPassword: true,
                errorText: _passwordError,
              ),
              SizedBox(
                height: Responsive.height(4.0,context),
              ),
              SizedBox(
                height: Responsive.height(7.0,context),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor:xColors.materialColor(xColors.mainColor)),
                  onPressed: () {
                    _login(context);
                  },
                  child: Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                        color: xColors.white,
                        fontSize: Responsive.width(4.0,context),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ), //Spacer(),
              SizedBox(
                height: Responsive.height(3.0,context),
              ),
             widget.type== 'user'? SizedBox(): GestureDetector(
                onTap: () {
                  Provider.of<AuthManage>(context, listen: false)
                      .toggleWidgets(currentPage: 2, type: widget.type);
                },
                child: Center(
                  child: Text(
                    "تسجيل حساب جديد",
                    style: TextStyle(
                        color: xColors.mainColor,
                        fontWeight: FontWeight.w800,
                        fontSize: Responsive.width(4.0,context)),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  _login(BuildContext context) async {
    String email =
        _mailController.text;
    String password = _passwordController.text;
    if (email != null &&
        email.isNotEmpty &&
        password != null &&
        password.isNotEmpty) {
      setState(() {
        _passwordError ='';
        _emailError ='';
      });
      await AuthService().signInWithEmailAndPassword(
          context: context,
          email: '${_mailController.text}.${widget.type}@tiba.com',
          password: _passwordController.text);
    } else {
      setState(() {
        if(email == null || email.isEmpty){
          _emailError = "أدخل اسم مستخدم صالح.";
          _passwordError ='';
        }else {
          _passwordError = "أدخل كلمة مرور صالحة.";
          _emailError ='';
        }
      });
    }
  }
}



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiba/server/auth.dart';
import 'package:tiba/utils/dimensions.dart';
import 'package:tiba/utils/utils.dart';
import '../wrapper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    delay();
  }

  void delay() {
    Future.delayed(Duration(milliseconds: 500), () {
    }).then((value) {
      Future.delayed(Duration(milliseconds: 2000), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => StreamProvider<User>.value(
                    value: AuthService().user, child: Wrapper())));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo_full.png",
          fit: BoxFit.cover,
          height: Responsive.width(65.0, context),
          width: Responsive.width(65.0, context),
        )
        ,
      ),
    );
  }

}

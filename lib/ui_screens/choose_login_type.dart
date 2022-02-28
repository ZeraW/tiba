import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tiba/server/auth_manage.dart';
import 'package:tiba/utils/dimensions.dart';
import 'package:tiba/utils/utils.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AuthManage>(builder: (context, auth, child) {
        return WillPopScope(
            onWillPop: () async {
              // You can do some work here.
              // Returning true allows the pop to happen, returning false prevents it.
              auth.onBackPressed();
              return false;
            }, child: auth.currentWidget());
      }),
    );
  }
}

class ChooseLoginType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Container(
                  height: Responsive.height(40,context),
                  width: Responsive.width(80,context),
                  padding: EdgeInsets.all(Responsive.width(5,context)),
                  child: Image.asset(
                    'assets/images/logo_full.png',
                    fit: BoxFit.fill,
                  ),
                )),
            Spacer(),
            Container(
              //rounded corner + color
              decoration: BoxDecoration(
                  color: xColors.mainColor,
                  borderRadius: BorderRadius.circular(Responsive.width(7,context))),
              //margin
              margin: EdgeInsets.symmetric(horizontal: Responsive.width(4,context)), // change 4 to 80 if something went wrong
              //height

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'اختيار مستخدم',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: Responsive.width(7,context)),
                  ),
                  Divider(
                    color: Colors.white,
                    indent: 40,
                    endIndent: 40,
                  ),
                  // on touch
                  GestureDetector(
                    onTap: () {
                      Provider.of<AuthManage>(context, listen: false)
                          .toggleWidgets(currentPage: 1, type: "student");
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Spacer(flex: 3,),
                          Text(
                            'طالب',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: Responsive.width(6,context)),
                          ),
                          Spacer(),
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(Responsive.width(10,context)),
                            child: Container(
                              height: Responsive.width(20,context),
                              width: Responsive.width(20,context),
                              color: xColors.accentColor,
                              child: Image.asset(
                                'assets/images/graduated.png',
                                fit: BoxFit.fitHeight,
                                height: Responsive.width(60,context),
                                width: Responsive.width(95,context),
                              ), // replace
                            ),
                          ),
                          Spacer(flex: 3,),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    indent: 40,
                    endIndent: 40,
                  ),
                  GestureDetector(
                      onTap: () {
                        Provider.of<AuthManage>(context, listen: false)
                            .toggleWidgets(currentPage: 1, type: "admin");
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Spacer(flex: 3,),

                            Text(
                              'مشرف',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: Responsive.width(6,context)),
                            ),
                            Spacer(),

                            ClipRRect(
                              borderRadius:
                              BorderRadius.circular(Responsive.width(10,context)),
                              child: Container(
                                height: Responsive.width(20,context),
                                width: Responsive.width(20,context),
                                color: xColors.accentColor,
                                child: Image.asset(
                                  'assets/images/admin.png',
                                  fit: BoxFit.fitHeight,
                                  height: Responsive.width(60,context),
                                  width: Responsive.width(95,context),
                                ), // replace
                              ),
                            ),
                            Spacer(flex: 3,),

                          ],
                        ),
                      )),
                  SizedBox(height: 5,)
                ],
              ),
            ),
            SizedBox(
              height: Responsive.width(4,context),
            )
          ],
        ));
  }
}

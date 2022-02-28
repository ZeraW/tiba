import 'package:flutter/material.dart';
import 'package:tiba/models/db_model.dart';
import 'package:tiba/utils/dimensions.dart';
import 'package:tiba/utils/utils.dart';
import 'package:provider/provider.dart';
import 'home_widgets/admin_screen.dart';
import 'home_widgets/student_screen.dart';

import 'home_widgets/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  UserModel user;

  HomeScreen(this.user);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String _pageName = 'لوحة الادارة';

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Widget>> _childrenAdmin = [
      {'لوحة الادارة': AdminScreen()},
      {'الملف الشخصي': AdminProfileScreen(widget.user)},
    ];

    final List<Map<String, Widget>> _childrenUser = [
      {'الرئيسية': StudentScreen()},
      {'الملف الشخصي': StudentProfileScreen(widget.user)},
    ];

    final List<BottomNavigationBarItem> _bottomNavigation = [
      BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined), label: widget.user.type == 'admin' ?_childrenAdmin[0].keys.first : _childrenUser[0].keys.first),
      BottomNavigationBarItem(
          icon: Icon(Icons.person_pin), label: _childrenAdmin[1].keys.first),
    ];

    if (widget.user != null) {
      if (widget.user != null &&
          widget.user.type == 'admin' &&
          _currentIndex == 0) {
        _pageName = 'لوحة الادارة';
        setState(() {});
      } else if (widget.user != null &&
          widget.user.type == 'student' &&
          _currentIndex == 0) {
        _pageName = 'الرئيسية';
        setState(() {});
      }
    }

    return Scaffold(
      appBar: new AppBar(
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: xColors.mainColor,
          title: Text(
            _pageName,
            style: TextStyle(
                color: xColors.white,
                fontWeight: FontWeight.bold,
                fontSize: Responsive.width(5, context)),
          )),
      body: widget.user != null
          ? Container(
              width: Responsive.width(100, context),
              child: widget.user != null && widget.user.type == 'admin'
                  ? _childrenAdmin[_currentIndex].values.first
                  : _childrenUser[_currentIndex].values.first)
          : SizedBox(),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigation,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageName = widget.user != null && widget.user.type == 'admin'
                ? _childrenAdmin[index].keys.first
                : _childrenUser[index].keys.first;
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        elevation: 0.0,
        selectedItemColor: xColors.white,
        backgroundColor: xColors.mainColor,
      ),
    );
  }
}

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiba/server/database_api.dart';
import 'package:tiba/utils/dimensions.dart';
import 'package:tiba/utils/utils.dart';
import 'package:photo_view/photo_view.dart';

class ManageSchedule extends StatefulWidget {
  int department, level ,semester,exam;


  ManageSchedule({Key key, this.department, this.level ,this.semester,this.exam}) : super(key: key);

  @override
  _ManageScheduleState createState() => _ManageScheduleState();
}

class _ManageScheduleState extends State<ManageSchedule> {
  String image;

  void getImage() async{
    String url ='';
    if(widget.exam!=null){
      url = 'images/schedule/D${widget.department}L${widget.level}S${widget.semester}e${widget.exam}.png';

    }else {
      url = 'images/schedule/D${widget.department}L${widget.level}S${widget.semester}.png';
    }

    image = await FirebaseStorage.instance
        .ref(url)
        .getDownloadURL();
    setState(() {

    });
  }


  @override
  void initState() {
    super.initState();
    getImage();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: xColors.mainColor,
          title: Text(
            'الجدول',
          )),
      body: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.width(5, context),vertical: Responsive.height(2, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: PhotoView(
                imageProvider: NetworkImage('$image'),
                maxScale: PhotoViewComputedScale.covered * 1.35,
                minScale: PhotoViewComputedScale.contained,
                initialScale: PhotoViewComputedScale.contained,
                backgroundDecoration: BoxDecoration(color: Colors.transparent),
              ))

            ],
          ),
        ),
      ),
    );
  }
}

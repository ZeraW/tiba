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

    Future<void> _takePicture() async {
      final imageFile = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);

      if (imageFile == null) {
        return;
      }else {
        String imageId ='';
        if(widget.exam!=null){
          imageId = 'schedule/D${widget.department}L${widget.level}S${widget.semester}e${widget.exam}';
        }else {
          imageId = 'schedule/D${widget.department}L${widget.level}S${widget.semester}';
        }
        await (DatabaseService().uploadImageToStorage(id:imageId,file: File(imageFile.path)));
        getImage();
      }

    }

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
              Text('اضف الجدول'),
              ElevatedButton(
                onPressed: () {
                  _takePicture();
                },
                child: Text('اضغط لأضافة الجدول'),
                style: ButtonStyle(
                    backgroundColor: xColors.materialColor(xColors.mainColor)),
              ),
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

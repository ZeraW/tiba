import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:tiba/models/tiba_model.dart';
import '../models/db_model.dart';
import '../wrapper.dart';

class DatabaseService {
  // Users collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

/////////////////////////////////// User ///////////////////////////////////
  //get my user


  Stream<UserModel> get getUserById {
    return userCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .map((event) => UserModel.fromJson(event.data()));
  }

  Stream<List<UserModel>> getLiveUsers(int depart, int level) {
    return userCollection
        .where('keyWords.department', isEqualTo: depart)
        .where('keyWords.level', isEqualTo: level)
        .snapshots()
        .map(UserModel().fromQuery);
  }

  //upload Image method
  Future uploadImageToStorage({ File file, String id}) async {
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref('images/$id.png');

    firebase_storage.UploadTask task = ref.putFile(file);

    // We can still optionally use the Future alongside the stream.
    try {
      //update image
      await task;
      String url = await FirebaseStorage.instance
          .ref('images/${id}.png')
          .getDownloadURL();

      return url;
    } on firebase_storage.FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    }
  }

  //updateUserData
  Future<void> updateUserData({UserModel user}) async {
    return await userCollection.doc(user.id).set(user.toJson());
  }


  //update score
  Future updateScore({ String title, String uid, var scores,  int totalScore}) async {
    var ref = userCollection.doc(uid).collection('data').doc('score');

    ref.get().then((value) {
      if (value.exists) {
        return  ref.update({
          '$title': scores,
          '${title}Score': totalScore,
        });
      } else {
        UserScore newReport = UserScore();
        return ref.set(newReport.toJson()).then((value) {
          ref.update({
            '$title': scores,
            '${title}Score': totalScore,
          });

        });
      }
    });
  }

  Stream<UserScore>  getUserScore(uid) {
    return userCollection
        .doc(uid).collection('data').doc('score')
        .snapshots()
        .map((event) => UserScore.fromJson(event.data()));
  }

/////////////////////////////////// User ///////////////////////////////////

/////////////////////////////////// FixedData ///////////////////////////////////

  Future<TibaModel> getTibaData() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    return TibaModel.fromJson(data);
  }
/////////////////////////////////// FixedData ///////////////////////////////////

}

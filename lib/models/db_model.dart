import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id, password, name, userId, type;

  int level, department;
  final Map<String, int> keyWords;

  UserModel(
      {this.id,
      this.password,
      this.name,
      this.userId,
      this.type,
      this.level,
      this.department,
      this.keyWords});

  UserModel.fromSnapShot(DocumentSnapshot doc)
      : id = doc.get('id'),
        password = doc.get('password'),
        name = doc.get('name'),
        userId = doc.get('userId'),
        level = doc.get('level'),
        keyWords = doc.get('keyWords') != null
            ? Map<String, int>.from(doc.get('keyWords'))
            : {},
        department = doc.get('department'),
        type = doc.get('type');

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        password = json['password'],
        name = json['name'],
        userId = json['userId'],
        level = json['level'],
        keyWords = json['keyWords'] != null
            ? Map<String, int>.from(json['keyWords'])
            : {},
        department = json['department'],
        type = json['type'];

  List<UserModel> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserModel(
          id: doc.get('id'),
          password: doc.get('password'),
          name: doc.get('name'),
          userId: doc.get('userId'),
          level: doc.get('level'),
          keyWords: doc.get('keyWords') != null
              ? Map<String, int>.from(doc.get('keyWords'))
              : {},
          department: doc.get('department'),
          type: doc.get('type'));
    }).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
      'name': name,
      'userId': userId,
      'level': level,
      'keyWords': {'level': level, 'department': department},
      'department': department,
      'type': type,
    };
  }
}

class UserScore {
  final Map<String, int> y1t1, y1t2, y2t1, y2t2, y3t1, y3t2, y4t1, y4t2;
  final int y1t1Score,
      y1t2Score,
      y2t1Score,
      y2t2Score,
      y3t1Score,
      y3t2Score,
      y4t1Score,
      y4t2Score;

  UserScore(
      {this.y1t1,
      this.y1t2,
      this.y2t1,
      this.y2t2,
      this.y3t1,
      this.y3t2,
      this.y4t1,
      this.y4t2,
      this.y1t1Score,
      this.y1t2Score,
      this.y2t1Score,
      this.y2t2Score,
      this.y3t1Score,
      this.y3t2Score,
      this.y4t1Score,
      this.y4t2Score});

  Map<String, int> getMap(String year) {
    switch (year) {
      case 'y1t1':
        return this.y1t1;
        break;
      case 'y1t2':
        return this.y1t2;
        break;
      case 'y2t1':
        return this.y2t1;
        break;
      case 'y2t2':
        return this.y2t2;
        break;
      case 'y3t1':
        return this.y3t1;
        break;
      case 'y3t2':
        return this.y3t2;
        break;
      case 'y4t1':
        return this.y4t1;
        break;
      case 'y4t2':
        return this.y4t2;
        break;
      default:
        return null;
    }
  }

  int getScore(String year) {
    switch (year) {
      case 'y1t1':
        return this.y1t1Score;
        break;
      case 'y1t2':
        return this.y1t2Score;
        break;
      case 'y2t1':
        return this.y2t1Score;
        break;
      case 'y2t2':
        return this.y2t2Score;
        break;
      case 'y3t1':
        return this.y3t1Score;
        break;
      case 'y3t2':
        return this.y3t2Score;
        break;
      case 'y4t1':
        return this.y4t1Score;
        break;
      case 'y4t2':
        return this.y4t2Score;
        break;
      default:
        return 0;
    }
  }

  UserScore.fromSnapShot(DocumentSnapshot doc)
      : y1t1 = doc.get('y1t1') != null
            ? Map<String, int>.from(doc.get('y1t1'))
            : {},
        y1t2 = doc.get('y1t2') != null
            ? Map<String, int>.from(doc.get('y1t2'))
            : {},
        y2t1 = doc.get('y2t1') != null
            ? Map<String, int>.from(doc.get('y2t1'))
            : {},
        y2t2 = doc.get('y2t2') != null
            ? Map<String, int>.from(doc.get('y2t2'))
            : {},
        y3t1 = doc.get('y3t1') != null
            ? Map<String, int>.from(doc.get('y3t1'))
            : {},
        y3t2 = doc.get('y3t2') != null
            ? Map<String, int>.from(doc.get('y3t2'))
            : {},
        y4t1 = doc.get('y4t1') != null
            ? Map<String, int>.from(doc.get('y4t1'))
            : {},
        y4t2 = doc.get('y4t2') != null
            ? Map<String, int>.from(doc.get('y4t2'))
            : {},
        y1t1Score = doc.get('y1t1Score'),
        y1t2Score = doc.get('y1t2Score'),
        y2t1Score = doc.get('y2t1Score'),
        y2t2Score = doc.get('y2t2Score'),
        y3t1Score = doc.get('y3t1Score'),
        y3t2Score = doc.get('y3t2Score'),
        y4t1Score = doc.get('y4t1Score'),
        y4t2Score = doc.get('y4t2Score');

  UserScore.fromJson(Map<String, dynamic> json)
      : y1t1 = json['y1t1'] != null ? Map<String, int>.from(json['y1t1']) : {},
        y1t2 = json['y1t2'] != null ? Map<String, int>.from(json['y1t2']) : {},
        y2t1 = json['y2t1'] != null ? Map<String, int>.from(json['y2t1']) : {},
        y2t2 = json['y2t2'] != null ? Map<String, int>.from(json['y2t2']) : {},
        y3t1 = json['y3t1'] != null ? Map<String, int>.from(json['y3t1']) : {},
        y3t2 = json['y3t2'] != null ? Map<String, int>.from(json['y3t2']) : {},
        y4t1 = json['y4t1'] != null ? Map<String, int>.from(json['y4t1']) : {},
        y4t2 = json['y4t2'] != null ? Map<String, int>.from(json['y4t2']) : {},
        y1t1Score = json['y1t1Score'],
        y1t2Score = json['y1t2Score'],
        y2t1Score = json['y2t1Score'],
        y2t2Score = json['y2t2Score'],
        y3t1Score = json['y3t1Score'],
        y3t2Score = json['y3t2Score'],
        y4t1Score = json['y4t1Score'],
        y4t2Score = json['y4t2Score'];

  List<UserScore> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserScore(
          y1t1: doc.get('y1t1') != null
              ? Map<String, int>.from(doc.get('y1t1'))
              : {},
          y1t2: doc.get('y1t2') != null
              ? Map<String, int>.from(doc.get('y1t2'))
              : {},
          y2t1: doc.get('y2t1') != null
              ? Map<String, int>.from(doc.get('y2t1'))
              : {},
          y2t2: doc.get('y2t2') != null
              ? Map<String, int>.from(doc.get('y2t2'))
              : {},
          y3t1: doc.get('y3t1') != null
              ? Map<String, int>.from(doc.get('y3t1'))
              : {},
          y3t2: doc.get('y3t2') != null
              ? Map<String, int>.from(doc.get('y3t2'))
              : {},
          y4t1: doc.get('y4t1') != null
              ? Map<String, int>.from(doc.get('y4t1'))
              : {},
          y4t2: doc.get('y4t2') != null
              ? Map<String, int>.from(doc.get('y4t2'))
              : {},
          y1t1Score: doc.get('y1t1Score'),
          y1t2Score: doc.get('y1t2Score'),
          y2t1Score: doc.get('y2t1Score'),
          y2t2Score: doc.get('y2t2Score'),
          y3t1Score: doc.get('y3t1Score'),
          y3t2Score: doc.get('y3t2Score'),
          y4t1Score: doc.get('y4t1Score'),
          y4t2Score: doc.get('y4t2Score'));
    }).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'y1t1': y1t1,
      'y1t2': y1t2,
      'y2t1': y2t1,
      'y2t2': y2t2,
      'y3t1': y3t1,
      'y3t2': y3t2,
      'y4t1': y4t1,
      'y4t2': y4t2,
      'y1t1Score': y1t1Score,
      'y1t2Score': y1t2Score,
      'y2t1Score': y2t1Score,
      'y2t2Score': y2t2Score,
      'y3t1Score': y3t1Score,
      'y3t2Score': y3t2Score,
      'y4t1Score': y4t1Score,
      'y4t2Score': y4t2Score
    };
  }
}

class TibaModel {
  List<LevelsNames> levelsNames;
  List<DepartmentsNames> departmentsNames;
  List<Semesters> semesters;

  TibaModel({this.levelsNames, this.departmentsNames, this.semesters});

  TibaModel.fromJson(Map<String, dynamic> json) {
    if (json['levels_names'] != null) {
      levelsNames = new List<LevelsNames>();
      json['levels_names'].forEach((v) {
        levelsNames.add(new LevelsNames.fromJson(v));
      });
    }
    if (json['departments_names'] != null) {
      departmentsNames = new List<DepartmentsNames>();
      json['departments_names'].forEach((v) {
        departmentsNames.add(new DepartmentsNames.fromJson(v));
      });
    }
    if (json['semesters'] != null) {
      semesters = new List<Semesters>();
      json['semesters'].forEach((v) {
        semesters.add(new Semesters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.levelsNames != null) {
      data['levels_names'] = this.levelsNames.map((v) => v.toJson()).toList();
    }
    if (this.departmentsNames != null) {
      data['departments_names'] =
          this.departmentsNames.map((v) => v.toJson()).toList();
    }
    if (this.semesters != null) {
      data['semesters'] = this.semesters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LevelsNames {
  int id;
  String level;

  LevelsNames({this.id, this.level});

  LevelsNames.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['level'] = this.level;
    return data;
  }
}

class DepartmentsNames {
  int id;
  String department;

  DepartmentsNames({this.id, this.department});

  DepartmentsNames.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    department = json['department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['department'] = this.department;
    return data;
  }
}

class Semesters {
  int semesterType;
  String semesterName;
  List<Levels> levels;

  Semesters({this.semesterType, this.semesterName, this.levels});

  Semesters.fromJson(Map<String, dynamic> json) {
    semesterType = json['semester_type'];
    semesterName = json['semester_name'];
    if (json['levels'] != null) {
      levels = new List<Levels>();
      json['levels'].forEach((v) {
        levels.add(new Levels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['semester_type'] = this.semesterType;
    data['semester_name'] = this.semesterName;
    if (this.levels != null) {
      data['levels'] = this.levels.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Levels {
  int id;
  String levelName;
  List<Department> department;

  Levels({this.id, this.levelName, this.department});

  Levels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    levelName = json['level_name'];
    if (json['department'] != null) {
      department = new List<Department>();
      json['department'].forEach((v) {
        department.add(new Department.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['level_name'] = this.levelName;
    if (this.department != null) {
      data['department'] = this.department.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Department {
  String type;
  List<String> subjects;
  int id;

  Department({this.type, this.subjects, this.id});

  Department.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    subjects = json['subjects'].cast<String>();
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['subjects'] = this.subjects;
    data['id'] = this.id;
    return data;
  }
}

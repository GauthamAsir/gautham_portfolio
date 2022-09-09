import 'package:responsive_portfolio/global.dart';

class FullDataModel {
  List<CodingModel>? codingList;
  List<KnowledgeModel>? knowledgeList;
  List<LinksModel>? linksList;
  PersonalDataModel? personalData;
  List<ProjectModel>? projectList;
  List<SkillsModel>? skillsList;

  FullDataModel(
      {this.codingList,
      this.knowledgeList,
      this.linksList,
      this.personalData,
      this.projectList,
      this.skillsList});

  bool get isNull =>
      codingList == null ||
      knowledgeList == null ||
      linksList == null ||
      personalData == null ||
      projectList == null ||
      skillsList == null;

  void sort({FetchType? fetchType = FetchType.All}) {
    switch (fetchType) {
      case FetchType.Coding:
        _sortCodingList();
        break;
      case FetchType.Knowledge:
        _sortKnowledgeList();
        break;
      case FetchType.Project:
        _sortProjectList();
        break;
      case FetchType.Skills:
        _sortSkillsList();
        break;
      default:
        _sortCodingList();
        _sortKnowledgeList();
        _sortProjectList();
        _sortSkillsList();
        break;
    }
  }

  void _sortCodingList() {
    codingList!.sort((a, b) => a.position!.compareTo(b.position!));
  }

  void _sortKnowledgeList() {
    knowledgeList!.sort((a, b) => a.position!.compareTo(b.position!));
  }

  void _sortProjectList() {
    projectList!.sort((a, b) => a.position!.compareTo(b.position!));
  }

  void _sortSkillsList() {
    skillsList!.sort((a, b) => a.position!.compareTo(b.position!));
  }
}

class CodingModel extends _BaseModel {
  CodingModel({int? id, int? percentage, int? position, String? name})
      : super(position: position, id: id, name: name, percentage: percentage);

  static CodingModel fromMap(
      {required Map<String, dynamic> snap, required int id}) {
    _BaseModel baseModel = _BaseModel.fromMapBase(id: id, snap: snap);

    return CodingModel(
        position: baseModel.position,
        name: baseModel.name,
        percentage: baseModel.percentage,
        id: baseModel.id);
  }
}

class KnowledgeModel {
  int? id, position;
  String? name;
  bool? active;

  KnowledgeModel({this.id, this.position, this.name, this.active});

  Map<String, dynamic> toMap() {
    return {
      nameString: name ?? '',
      activeString: active ?? false,
      positionString: position ?? 0
    };
  }

  static KnowledgeModel fromMap(
      {required Map<String, dynamic> snap, required int id}) {
    return KnowledgeModel(
        id: id,
        active: snap[activeString] ?? false,
        name: snap[nameString] ?? '',
        position: snap[positionString] ?? 0);
  }
}

class LinksModel {
  int? id;
  String? name, url;

  LinksModel({this.id, this.name, this.url});

  Map<String, dynamic> toMap() {
    return {nameString: name ?? '', urlString: url ?? ''};
  }

  static LinksModel fromMap(
      {required Map<String, dynamic> snap, required int id}) {
    return LinksModel(
        id: id,
        name: snap[nameString] ?? '',
        url: snap[urlString] ?? 'https://www.google.com/');
  }
}

class PersonalDataModel {
  String? name, education, image, role, residence;
  int? age;

  PersonalDataModel(
      {this.name,
      this.education,
      this.image,
      this.role,
      this.age,
      this.residence});

  Map<String, dynamic> toMap() {
    return {
      nameString: name ?? '',
      educationString: education ?? '',
      imageString: image ?? '',
      roleString: role ?? '',
      ageString: age ?? '',
      residenceString: residence ?? ''
    };
  }

  static PersonalDataModel fromMap(Map<String, dynamic> snap) {
    return PersonalDataModel(
        name: snap[nameString] ?? '',
        age: snap[ageString] ?? 0,
        education: snap[educationString] ?? '',
        image: snap[imageString] ?? '',
        role: snap[roleString] ?? '',
        residence: snap[residenceString] ?? '');
  }
}

class ProjectModel {
  final String? title, description, longDesc;
  final int? id, position;

  const ProjectModel(
      {this.title, this.description, this.longDesc, this.id, this.position});

  Map<String, dynamic> toMap({int? id, position}) {
    return {
      'title': title ?? '',
      'description': description ?? '',
      'longDesc': longDesc ?? '',
      'id': id,
      'position': position
    };
  }

  static ProjectModel fromMap(Map<String, dynamic> snap) {
    return ProjectModel(
      id: snap['id'],
      position: snap['position'],
      description: snap['description'] ?? '',
      longDesc: snap['longDesc'] ?? '',
      title: snap['title'] ?? '',
    );
  }
}

class SkillsModel extends _BaseModel {
  SkillsModel({int? id, int? percentage, int? position, String? name})
      : super(position: position, id: id, name: name, percentage: percentage);

  static SkillsModel fromMap(
      {required Map<String, dynamic> snap, required int id}) {
    _BaseModel baseModel = _BaseModel.fromMapBase(id: id, snap: snap);

    return SkillsModel(
        position: baseModel.position,
        name: baseModel.name,
        percentage: baseModel.percentage,
        id: baseModel.id);
  }
}

class _BaseModel {
  final int? id, percentage, position;

  final String? name;

  _BaseModel({this.id, this.percentage, this.position, this.name});

  Map<String, dynamic> toMap() {
    return {
      nameString: name ?? '',
      percentageString: percentage ?? 0,
      positionString: position ?? 0
    };
  }

  static _BaseModel fromMapBase(
      {required Map<String, dynamic> snap, required int id}) {
    return _BaseModel(
        id: id,
        percentage: snap[percentageString] ?? 0,
        name: snap[nameString] ?? '',
        position: snap[positionString] ?? 0);
  }
}

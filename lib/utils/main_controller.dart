import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/global.dart';
import 'package:responsive_portfolio/models/full_data_model.dart';

class MainController extends GetxController {
  RxBool showProjectDetails = false.obs;

  ScrollController projectScrollController = ScrollController();

  // RxList<ProjectModel> projects = RxList();

  Rx<FullDataModel> fullDataModel = Rx(FullDataModel());

  Future<bool> addOrUpdateProject(List<ProjectModel> list) async {
    List<Map<String, dynamic>> maps = [];

    list.forEach((element) {
      maps.add(element.toMap());
    });

    var data = await firestore
        .collection('Configs')
        .doc('data')
        .update({'projects': maps}).then((value) {
      return true;
    }).catchError((onError) {
      showCustomSnackBar(onError.toString());
      return false;
    });
    return data;
  }

  Future getData({FetchType? fetchType = FetchType.All}) async {
    switch (fetchType) {
      case FetchType.Skills:
        if (fullDataModel.value.skillsList != null &&
            fullDataModel.value.skillsList!.isNotEmpty) {
          return fullDataModel.value.skillsList!;
        }
        break;
      case FetchType.Project:
        if (fullDataModel.value.projectList != null &&
            fullDataModel.value.projectList!.isNotEmpty) {
          return fullDataModel.value.projectList!;
        }
        break;
      case FetchType.Knowledge:
        if (fullDataModel.value.knowledgeList != null &&
            fullDataModel.value.knowledgeList!.isNotEmpty) {
          return fullDataModel.value.knowledgeList!;
        }
        break;
      case FetchType.Coding:
        if (fullDataModel.value.codingList != null &&
            fullDataModel.value.codingList!.isNotEmpty) {
          return fullDataModel.value.codingList!;
        }
        break;
      case FetchType.Links:
        if (fullDataModel.value.linksList != null &&
            fullDataModel.value.linksList!.isNotEmpty) {
          return fullDataModel.value.linksList;
        }
        break;
      case FetchType.PersonalData:
        if (fullDataModel.value.personalData != null) {
          return fullDataModel.value.personalData!;
        }
        break;
      default:
        if (!fullDataModel.value.isNull) {
          return fullDataModel.value;
        }
        break;
    }

    String error = '';

    var res = await firestore
        .collection('Configs')
        .doc('data')
        .get()
        .catchError((onError) {
      error = onError.toString();
      log('Error Fetching Data: ${onError.toString()}');
    });

    if (res.exists && res.data() != null) {
      switch (fetchType) {
        case FetchType.Coding:
          _getCodingList(res.data()!);
          return fullDataModel.value.codingList ?? [];
        case FetchType.Knowledge:
          _getKnowledgeList(res.data());
          return fullDataModel.value.knowledgeList;
        case FetchType.Links:
          _getLinksList(res.data());
          return fullDataModel.value.linksList;
        case FetchType.PersonalData:
          _getPersonalData(res.data()!);
          return fullDataModel.value.personalData!;
        case FetchType.Project:
          _getProjects(res.data()!);
          return fullDataModel.value.projectList ?? [];
        case FetchType.Skills:
          _getSkillsList(res.data()!);
          return fullDataModel.value.skillsList!;
        default:
          _getCodingList(res.data()!);
          _getKnowledgeList(res.data());
          _getLinksList(res.data());
          _getPersonalData(res.data()!);
          _getProjects(res.data()!);
          _getSkillsList(res.data()!);
          return fullDataModel.value;
      }
    }

    return Response(body: error.isEmpty ? 'Data is empty' : error);
  }

  void _getLinksList(Map<String, dynamic>? map) {
    List data = map![linksString] ?? [];

    List<LinksModel> links = [];

    if (data.isNotEmpty) {
      if (fullDataModel.value.linksList != null) {
        fullDataModel.value.linksList!.clear();
      }

      for (int i = 0; i < data.length; i++) {
        // if (kDebugMode) {
        //   print(data[i]);
        // }

        links.add(LinksModel.fromMap(snap: data[i], id: i));
      }

      fullDataModel.value.linksList = links;

      if (kDebugMode) {
        log('Link List Length: ${fullDataModel.value.linksList!.length}');
      }
    }
  }

  void _getKnowledgeList(Map<String, dynamic>? map) {
    List data = map![knowledgeString] ?? [];

    List<KnowledgeModel> knowledges = [];

    if (data.isNotEmpty) {
      if (fullDataModel.value.knowledgeList != null) {
        fullDataModel.value.knowledgeList!.clear();
      }

      for (int i = 0; i < data.length; i++) {
        // if (kDebugMode) {
        //   print(data[i]);
        // }

        knowledges.add(KnowledgeModel.fromMap(snap: data[i], id: i));
      }

      fullDataModel.value.knowledgeList = knowledges;

      if (kDebugMode) {
        log('Knowledge List Length: ${fullDataModel.value.knowledgeList!.length}');
      }
    }
  }

  void _getSkillsList(Map<String, dynamic>? map) {
    List data = map![skillsString] ?? [];

    List<SkillsModel> skills = [];

    if (data.isNotEmpty) {
      if (fullDataModel.value.skillsList != null) {
        fullDataModel.value.skillsList!.clear();
      }

      for (int i = 0; i < data.length; i++) {
        // if (kDebugMode) {
        //   print(data[i]);
        // }

        skills.add(SkillsModel.fromMap(snap: data[i], id: i));
      }

      fullDataModel.value.skillsList = skills;

      if (kDebugMode) {
        log('Skills List Length: ${fullDataModel.value.skillsList!.length}');
      }
    }
  }

  void _getPersonalData(Map<String, dynamic>? map) {
    Map<String, dynamic> data = map![personalDataString] ?? [];

    if (data.isNotEmpty) {
      fullDataModel.value.personalData = PersonalDataModel.fromMap(data);
      log('Personal Data Added');
    }
  }

  void _getCodingList(Map<String, dynamic>? map) {
    List data = map![codingString] ?? [];

    List<CodingModel> codings = [];

    if (data.isNotEmpty) {
      if (fullDataModel.value.codingList != null) {
        fullDataModel.value.codingList!.clear();
      }

      for (int i = 0; i < data.length; i++) {
        // if (kDebugMode) {
        //   print(data[i]);
        // }

        codings.add(CodingModel.fromMap(snap: data[i], id: i));
      }

      fullDataModel.value.codingList = codings;

      if (kDebugMode) {
        log('Coding List Length: ${fullDataModel.value.codingList!.length}');
      }
    }
  }

  void _getProjects(Map<String, dynamic>? map) {
    List data = map!['projects'] ?? [];

    List<ProjectModel> projects = [];

    if (data.isNotEmpty) {
      if (fullDataModel.value.projectList != null) {
        fullDataModel.value.projectList!.clear();
      }

      for (int i = 0; i < data.length; i++) {
        projects.add(ProjectModel.fromMap(data[i], position: i, id: i));
      }

      fullDataModel.value.projectList = projects;

      if (kDebugMode) {
        log('Projects Length: ${fullDataModel.value.projectList!.length}');
      }
    }
  }
}

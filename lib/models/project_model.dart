class ProjectModel {
  final String? longDesc;
  final String? title;
  final String? framework;
  final int? position;
  final int? id;
  final String? description;
  final String? image;

  ProjectModel(
      {required this.longDesc,
      required this.title,
      required this.framework,
      required this.position,
      required this.id,
      required this.description,
      required this.image});

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
        longDesc: json['longDesc'],
        title: json['title'],
        framework: json['framework'],
        position: json['position'],
        id: json['id'],
        description: json['description'],
        image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {
      'longDesc': longDesc,
      'title': title,
      'framework': framework,
      'position': position,
      'id': id,
      'description': description,
      'image': image
    };
  }
}

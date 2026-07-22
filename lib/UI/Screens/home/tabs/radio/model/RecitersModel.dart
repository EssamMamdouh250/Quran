class ReciterModel {
  final int id;
  final String name;
  final List<MoshafModel> moshafList;

  ReciterModel({
    required this.id,
    required this.name,
    required this.moshafList,
  });

  factory ReciterModel.fromJson(Map<String, dynamic> json) {
    var list = json['moshaf'] as List? ?? [];
    List<MoshafModel> moshaf = list.map((i) => MoshafModel.fromJson(i)).toList();

    return ReciterModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      moshafList: moshaf,
    );
  }
}

class MoshafModel {
  final int id;
  final String name;
  final String server;

  MoshafModel({
    required this.id,
    required this.name,
    required this.server,
  });

  factory MoshafModel.fromJson(Map<String, dynamic> json) {
    return MoshafModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      server: json['server'] ?? '',
    );
  }
} 
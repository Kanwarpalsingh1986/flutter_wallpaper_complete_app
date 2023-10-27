
class ColorCodeModel {
  String id;
  String name;
  String code;

  ColorCodeModel({
    required this.id,
    required this.name,
    required this.code,
  });

  factory ColorCodeModel.fromJson(Map<String, dynamic> json) => ColorCodeModel(
    id: json["id"] ,
    name: json["name"],
    code: json["code"] ,
  );

}

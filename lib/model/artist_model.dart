class ArtistModel {
  String id;
  String? phone;
  String name;
  String? image;
  String? facebook;
  String? twitter;

  int status;
  int wallpapersCount;
  int totalDownloads;

  ArtistModel({
    required this.id,
    this.phone,
    this.image,
    required this.name,
    this.facebook,
    this.twitter,
    required this.status,
    required this.wallpapersCount,
    required this.totalDownloads,

  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) => ArtistModel(
    id: json["id"],
    phone: json["phone"],
    image: json["image"],
    name: json["name"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    status: json["status"],
    wallpapersCount: json["wallpapersCount"] ?? 0,
    totalDownloads: json["totalDownloads"] ?? 0,
  );
}

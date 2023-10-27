import 'package:music_streaming_mobile/helper/common_import.dart';

class WallpaperModel {
  String id;
  String name;

  // String date;
  String categoryName;
  String categoryId;
  String image;
  int status;
  int totalDownloads;
  int searchedCount;

  String colorCode;
  String colorName;
  String addedByUserId;
  int coinsToUnlock;
  DateTime createdAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WallpaperModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => name.hashCode ^ id.hashCode;

  WallpaperModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.categoryName,
    required this.colorCode,
    required this.colorName,
    // required this.date,
    required this.image,
    required this.status,
    required this.totalDownloads,
    required this.searchedCount,
    required this.addedByUserId,
    required this.coinsToUnlock,
    required this.createdAt,
  });

  factory WallpaperModel.fromJson(Map<String, dynamic> json) => WallpaperModel(
      id: json["id"],
      name: json["name"],
      categoryId: json["categoryId"],
      categoryName: json["categoryName"],
      status: json["status"],
      totalDownloads: json["totalDownloads"] ?? 0,
      searchedCount: json["searchedCount"] ?? 0,
      colorCode: json["colorCode"],
      colorName: json["colorName"] ?? '',
      image: json["image"],
      addedByUserId: json["addedByUserId"],
      coinsToUnlock: json["coinsToUnlock"] ?? 0,
      createdAt: json["createdAt"].toDate());

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "name": name,
  //       "genreId": categoryId,
  //       "genreName": categoryName,
  //       // "albumId": albumId,
  //       // "albumName": albumName,
  //       // "date": date,
  //       "status": status,
  //       "totalStreams": totalDownloads,
  //       "image": image,
  //     };

  String formattedTotalStreams() {
    if (totalDownloads > 1000) {
      return NumberFormat('#,##,000').format(totalDownloads);
    } else {
      return '$totalDownloads';
    }
  }

  bool isLiked() {
    if (getIt<UserProfileManager>().user != null) {
      return getIt<UserProfileManager>().user!.likedWallpapers.contains(id) ==
          true;
    }
    return false;
  }
}

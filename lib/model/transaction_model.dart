class TransactionModel {
  String id;
  String transactionValue;
  String packageName;
  String userId;
  String userName;
  String platform;
  String inAppId;
  int coins;

  TransactionModel(
      {required this.id,
      required this.transactionValue,
      required this.packageName,
      required this.userId,
      required this.userName,
      required this.platform,
      required this.inAppId,
        required this.coins

      });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        transactionValue: json["transactionValue"],
        packageName: json["packageName"],
        userId: json["userId"],
        userName: json["userName"],
        platform: json["platform"],
        inAppId: json["inAppId"],
        coins: json["coins"],

      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "transactionValue": transactionValue,
      "packageName": packageName,
      "userId": userId,
      "userName": userName,
      "platform": platform,
      "inAppId": inAppId,
      "coins": coins,

    };
  }
}

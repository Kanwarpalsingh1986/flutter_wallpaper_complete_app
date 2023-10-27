class PackageModel {
  String id = '';
  String name = '';
  int coins = 0;
  String inAppPurchaseIdIOS = '';
  String inAppPurchaseIdAndroid = '';

  PackageModel();

  factory PackageModel.fromJson(dynamic json) {
    PackageModel model = PackageModel();
    model.id = json['id'];
    model.name = json['name'];
    model.coins = json['coins'] ?? 0;

    model.inAppPurchaseIdIOS = json['in_app_purchase_id_ios'];
    model.inAppPurchaseIdAndroid = json['in_app_purchase_id_android'];

    return model;
  }
}

class PackageProducts {
  String id = '';
  String localizedPrice = '';
  String price = '';

  String title = '';

  PackageProducts({
    required this.id,
    required this.localizedPrice,
    required this.price,
    required this.title,
  });
}

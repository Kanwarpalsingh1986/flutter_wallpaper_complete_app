import 'package:music_streaming_mobile/helper/common_import.dart';
import 'package:get/get.dart';
import 'package:music_streaming_mobile/model/transaction_model.dart';

class BuyCoinsController extends GetxController {
  RxList<PackageProducts> packages = <PackageProducts>[].obs;
  List<PackageModel> packagesModel = <PackageModel>[];

  RxInt coins = 0.obs;

  final bool kAutoConsume = true;
  String subscribedProductId = '';

  late StreamSubscription purchaseUpdatedSubscription;
  late StreamSubscription purchaseErrorSubscription;
  late StreamSubscription connectionSubscription;
  List<IAPItem> items = [];
  IAPItem? currentPurchasingProduct;

  initiate() async {
    // prepare
    await FlutterInappPurchase.instance.initialize();

    connectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
      // print('connected: $connected');
    });

    purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      // print('purchase-updated: $productItem');
      if (productItem?.purchaseStateAndroid == PurchaseState.purchased ||
          productItem?.transactionStateIOS == TransactionState.purchased) {
        addCoins(200);
      }
    });

    purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {});

    AppUtil.checkInternet().then((value) {
      if (value) {
        getIt<FirebaseManager>().getAllPackages().then((packages) {
          packagesModel = packages;
          _getProduct(Platform.isIOS
              ? packages.map((e) => e.inAppPurchaseIdIOS.toString()).toList()
              : packages.map((e) => e.inAppPurchaseIdAndroid).toList());
        });
      }
    });
  }

  Future _getProduct(List<String> productIds) async {
    items = await FlutterInappPurchase.instance.getProducts(productIds);

    if (items.isNotEmpty) {
      packages.value = items
          .map((e) => PackageProducts(
                id: e.productId!,
                localizedPrice: e.localizedPrice!,
                price: e.price!,
                title: e.title!,
              ))
          .toList();

      update();
    }
  }

  showRewardedAds() {
    // RewardedInterstitialAds(onRewarded: () {
    //   ApiController().rewardCoins().then((response) {
    //     if (response.success == true) {
    //       getIt<UserProfileManager>().refreshProfile();
    //     } else {}
    //   });
    // }).loadInterstitialAd();
  }

  purchasePremium(String productId) {
    currentPurchasingProduct =
        items.where((element) => element.productId == productId).first;

    FlutterInappPurchase.instance.requestPurchase(productId).then((value) {
      // print(value);
    });
  }

  restorePurchase() {
    FlutterInappPurchase.instance.getAvailablePurchases().then((value) {
      AppUtil.showToast(
          message: LocalizationString.restorePurchaseDone, isSuccess: true);
    });
  }

  addCoins(int coins) {
    // getIt<FirebaseManager>().updateCoins(coins).then((value) async {
    //
    // });

    int coins = 0;

    if (Platform.isIOS) {
      coins = packagesModel
          .where((element) =>
              element.inAppPurchaseIdIOS ==
              currentPurchasingProduct!.productId!)
          .first
          .coins;
    } else {
      coins = packagesModel
          .where((element) =>
              element.inAppPurchaseIdAndroid ==
              currentPurchasingProduct!.productId!)
          .first
          .coins;
    }

    TransactionModel transaction = TransactionModel(
        id: getRandString(25),
        transactionValue: currentPurchasingProduct!.localizedPrice!,
        packageName: currentPurchasingProduct!.title!,
        userId: getIt<UserProfileManager>().user!.id,
        userName: getIt<UserProfileManager>().user!.infoToShow,
        platform: Platform.isIOS ? 'iOS' : 'Android',
        coins: coins,
        inAppId: currentPurchasingProduct!.productId!);

    getIt<FirebaseManager>().saveTransaction(transaction).then((result) async {
      if (result.status == true) {
        await getIt<UserProfileManager>().refreshProfile();

        AppUtil.showToast(
            message: LocalizationString.coinsAdded, isSuccess: true);
      } else {
        AppUtil.showToast(
            message: LocalizationString.errorMessage, isSuccess: true);
      }
    });
  }
}

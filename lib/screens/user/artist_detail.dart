import 'package:flutter/material.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';
import 'package:get/get.dart';

class ArtistDetail extends StatefulWidget {
  final String id;

  const ArtistDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<ArtistDetail> createState() => _ArtistDetailState();
}

class _ArtistDetailState extends State<ArtistDetail> {
  final WallpaperController wallpaperController = Get.find();
  final ArtistController artistController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    wallpaperController.loadWallpapers(artistId: widget.id);
    artistController.getArtistDetail(id: widget.id);
    super.initState();
    InterstitialAds().loadInterstitialAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    wallpaperController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          GetBuilder<ArtistController>(
              init: artistController,
              builder: (context) {
                return BackNavBar(
                  title:artistController.artist.value?.name ?? LocalizationString.artist,
                  backTapHandler: () {
                    Get.back();
                  },
                );
              }),
          GetBuilder<ArtistController>(
              init: artistController,
              builder: (context) {
                return creatorInfo().p16;
              }),
          Container(
            height: 0.1,
            width: double.infinity,
            color: Theme.of(context).primaryColorLight,
          ).vP8,
          Expanded(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: loadView().hP16),
          )
        ],
      ),
    );
  }

  Widget loadView() {
    return GetBuilder<ArtistController>(
        init: artistController,
        builder: (context) {
          return wallpapersView();
        });
  }

  Widget creatorInfo() {
    return artistController.isLoading == true
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AvatarView(
                url: artistController.artist.value!.image,
                name: artistController.artist.value!.name,
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(artistController.artist.value!.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      artistController.artist.value!.wallpapersCount > 0
                          ? Text('${artistController.artist.value!.wallpapersCount} wallpapers,',
                                  style: Theme.of(context).textTheme.bodyLarge)
                              .rP8
                          : Container(),
                      artistController.artist.value!.totalDownloads > 0
                          ? Text('${artistController.artist.value!.totalDownloads} downloads',
                                  style: Theme.of(context).textTheme.bodyLarge)
                              .rP8
                          : Container(),
                    ],
                  ),
                ],
              )
            ],
          );
  }

  Widget wallpapersView() {
    return GetBuilder<WallpaperController>(
        init: wallpaperController,
        builder: (ctx) {
          return GridView.builder(
            padding: const EdgeInsets.only(top: 0, bottom: 50),
            itemCount: wallpaperController.wallpapers.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.65,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemBuilder: (BuildContext context, int index) {
              return WallpaperTile(
                  wallpaper: wallpaperController.wallpapers[index],
                  showCoins: true,
                  likeUnlikeCallback: () {
                    if (getIt<UserProfileManager>().user == null) {
                      Get.to(() => const AskForLogin());
                    } else {
                      wallpaperController.likeUnlikeWallpaper(
                          wallpaperController.wallpapers[index]);
                    }
                  });
            },
          );
        });
  }
}

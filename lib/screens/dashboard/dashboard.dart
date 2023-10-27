import 'package:flutter/material.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';
import 'package:get/get.dart';

class Section {
  Section({required this.heading, required this.items, required this.dataType});

  String heading;
  List<dynamic> items = [];
  DataType dataType = DataType.wallpapers;
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final WallpaperController wallpaperController = Get.find();
  late InfiniteScrollController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = InfiniteScrollController();
    wallpaperController.loadDashboardData();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Dashboard oldWidget) {
    // TODO: implement didUpdateWidget
    wallpaperController.loadDashboardData();
    super.didUpdateWidget(oldWidget);
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
        body: dashBoardView());
  }

  Widget dashBoardView() {
    return Column(
      children: [
        TitleBar(title: LocalizationString.home),
        SizedBox(
          height: 40,
          child: GetBuilder<WallpaperController>(
              init: wallpaperController,
              builder: (ctx) {
                return HorizontalMenuBar(
                    padding: const EdgeInsets.only(left: 16),
                    onSegmentChange: (segment) {
                      wallpaperController.selectSegment(segment);
                    },
                    childs: wallpaperController.filtersList
                        .map((e) => SegmentTab(
                            activeTextStyle:
                                Theme.of(context).textTheme.titleLarge,
                            inActiveTextStyle:
                                Theme.of(context).textTheme.titleLarge,
                            activeBgColor: Theme.of(context).primaryColor,
                            title: e,
                            isSelected:
                                e == wallpaperController.selectedFilter.value))
                        .toList());
              }),
        ),
        Expanded(child: wallpapersList().hP16),
      ],
    );
  }

  Widget wallpapersList() {
    return GetBuilder<WallpaperController>(
        init: wallpaperController,
        builder: (ctx) {
          return GridView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemCount: wallpaperController.wallpapers.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.6,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemBuilder: (BuildContext ctx, int index) {
              return SizedBox(
                height: 200,
                child: WallpaperTile(
                  wallpaper: (wallpaperController.wallpapers[index]),
                  showCoins: true,
                  likeUnlikeCallback: () {
                    if (getIt<UserProfileManager>().user == null) {
                      Get.to(() => const AskForLogin());
                    } else {
                      wallpaperController.likeUnlikeWallpaper(
                          wallpaperController.wallpapers[index]);
                    }
                  },
                ),
              );
            },
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';

class CustomNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Widget child;
  final bool? showSeparator;
  final Color? backgroundColor;

  const CustomNavigationBar(
      {Key? key, required this.child, this.showSeparator, this.backgroundColor})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: preferredSize,
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: backgroundColor ?? Theme.of(context).backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 50, child: child).tp(50),
                    const Spacer(),
                  ],
                ).hP16,
              ),
            ),
            showSeparator == true
                ? Divider(height: 1, color: Theme.of(context).dividerColor)
                : Container()
          ],
        ));
  }
}

class BackNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String? title;
  final bool? showDivider;
  final bool? centerTitle;
  final VoidCallback backTapHandler;

  const BackNavigationBar(
      {Key? key,
      this.title,
      this.showDivider,
      this.centerTitle,
      required this.backTapHandler})
      : preferredSize = const Size.fromHeight(70.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: preferredSize,
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              Row(
                children: [
                  ThemeIconWidget(ThemeIcon.backArrow,
                          size: 20, color: Theme.of(context).iconTheme.color)
                      .ripple(() {
                    backTapHandler();
                    // Navigator.of(context).pop();
                  }),
                  centerTitle == true ? const Spacer() : Container(),
                  centerTitle != true ? Container(width: 20) : Container(),
                  title != null
                      ? Text(title!,
                              style: Theme.of(context).textTheme.titleLarge)
                          .ripple(() {
                          backTapHandler();
                          //Navigator.of(context).pop();
                        })
                      : Container(),
                  centerTitle == true ? const Spacer() : Container(),
                  Container(width: 20)
                ],
              ).tp(55).hP16,
              const Spacer(),
              showDivider == true
                  ? Divider(height: 1, color: Theme.of(context).dividerColor)
                  : Container()
            ],
          ),
        ));
  }
}

class NavigationBarWithCloseBtn extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String? title;
  final bool? showDivider;
  final bool? centerTitle;

  const NavigationBarWithCloseBtn(
      {Key? key, this.title, this.showDivider, this.centerTitle})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: preferredSize,
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              Row(
                children: [
                  const ThemeIconWidget(ThemeIcon.close, size: 20).ripple(() {
                    // Routemaster.of(context).pop();
                  }),
                  centerTitle == true ? const Spacer() : Container(),
                  centerTitle != true ? Container(width: 20) : Container(),
                  title != null
                      ? Text(title!,
                              style: Theme.of(context).textTheme.bodyLarge)
                          .ripple(() {
                          // NavigationService.instance.goBack();
                          // Routemaster.of(context).pop();
                        })
                      : Container(),
                  centerTitle == true ? const Spacer() : Container(),
                  Container(width: 20)
                ],
              ).tp(55).hP16,
              const Spacer(),
              showDivider == true
                  ? Divider(height: 1, color: Theme.of(context).dividerColor)
                  : Container()
            ],
          ),
        ));
  }
}

class TitleNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String? title;
  final bool? showDivider;

  const TitleNavigationBar({Key? key, required this.title, this.showDivider})
      : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: preferredSize,
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title!, style: Theme.of(context).textTheme.bodyLarge).bP16,
              showDivider == true
                  ? Divider(height: 1, color: Theme.of(context).dividerColor)
                  : Container()
            ],
          ),
        ));
  }
}

class BackNavBar extends StatelessWidget {
  final String? title;
  final bool? showDivider;
  final bool? centerTitle;
  final VoidCallback backTapHandler;

  const BackNavBar(
      {Key? key,
      this.title,
      this.showDivider,
      this.centerTitle,
      required this.backTapHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: Theme.of(context).backgroundColor.withOpacity(0.5),
      child: Column(
        children: [
          Row(
            children: [
              ThemeIconWidget(ThemeIcon.backArrow,
                      size: 20, color: Theme.of(context).iconTheme.color)
                  .ripple(() {
                backTapHandler();
                // Navigator.of(context).pop();
              }),
              centerTitle == true ? const Spacer() : Container(),
              centerTitle != true ? Container(width: 20) : Container(),
              title != null
                  ? Text(title!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w600))
                      .ripple(() {
                      backTapHandler();
                      //Navigator.of(context).pop();
                    })
                  : Container(),
              centerTitle == true ? const Spacer() : Container(),
              Container(width: 20)
            ],
          ).tp(55).hP16,
          const Spacer(),
          showDivider == true
              ? Divider(height: 1, color: Theme.of(context).dividerColor)
              : Container()
        ],
      ),
    );
  }
}

class TitleBar extends StatelessWidget {
  final String? title;
  final bool? showDivider;

  const TitleBar({Key? key, required this.title, this.showDivider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title!,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w600))
              .bP16,
          showDivider == true
              ? Divider(height: 1, color: Theme.of(context).dividerColor)
              : Container()
        ],
      ),
    );
  }
}

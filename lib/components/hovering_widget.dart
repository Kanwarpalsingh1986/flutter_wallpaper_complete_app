// import 'package:flutter/material.dart';
// import 'package:music_streaming_mobile/helper/common_import.dart';
//
// class PlayIconHoveringWidget extends StatefulWidget {
//   final Widget child;
//   final VoidCallback tapHandler;
//
//   const PlayIconHoveringWidget({Key? key, required this.child, required this.tapHandler}): super(key: key);
//
//   @override
//   _PlayIconHoveringWidget createState() => _PlayIconHoveringWidget();
// }
//
// class _PlayIconHoveringWidget extends State<PlayIconHoveringWidget> {
//   bool isHover = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         child: Stack(
//           children: [
//             InkWell(
//               onTap: widget.tapHandler,
//               child: Stack(
//                 children: [
//                   widget.child.p(isHover == true ? 5 : 0),
//                   Positioned(
//                     left: 0,
//                     right: 0,
//                     top: 0,
//                     bottom: 0,
//                     child: isHover == true
//                         ? Container(
//                             decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [
//                                 Colors.transparent,
//                                 AppTheme.singleton.primaryBackgroundColor
//                                     .withOpacity(0.5),
//                                 AppTheme.singleton.primaryBackgroundColor,
//                               ],
//                             )),
//                             child: Center(
//                               child: Container(
//                                 color: AppTheme.singleton.headingTextColor,
//                                 height: 50,
//                                 width: 50,
//                                 child: ThemeIconWidget(
//                                   ThemeIcon.play,
//                                   size: 30,
//                                   color: AppTheme.singleton.themeColor,
//                                 ).p4,
//                               ).circular,
//                             ),
//                           )
//                         : Container(),
//                   ),
//                 ],
//               ),
//               onHover: (val) {
//                 setState(() {
//                   isHover = val;
//                 });
//               },
//             ),
//           ],
//         ));
//   }
// }
//
// class HoveringWidget extends StatefulWidget {
//   final Widget child;
//   final VoidCallback tapHandler;
//
//   const HoveringWidget({Key? key, required this.child, required this.tapHandler}): super(key: key);
//
//   @override
//   HoveringWidgetState createState() => HoveringWidgetState();
// }
//
// class HoveringWidgetState extends State<HoveringWidget> {
//   bool isHover = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         child: Stack(
//           children: [
//             InkWell(
//               onTap: widget.tapHandler,
//               child: Stack(
//                 children: [
//                   widget.child.p(isHover == true ? 5 : 0),
//                   Positioned(
//                     left: 0,
//                     right: 0,
//                     top: 0,
//                     bottom: 0,
//                     child: isHover == true
//                         ? Container(
//                             decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [
//                                 Colors.transparent,
//                                 AppTheme.singleton.primaryBackgroundColor
//                                     .withOpacity(0.5),
//                                 AppTheme.singleton.primaryBackgroundColor,
//                               ],
//                             )),
//                           )
//                         : Container(),
//                   ),
//                 ],
//               ),
//               onHover: (val) {
//                 setState(() {
//                   isHover = val;
//                 });
//               },
//             ),
//           ],
//         ));
//   }
// }

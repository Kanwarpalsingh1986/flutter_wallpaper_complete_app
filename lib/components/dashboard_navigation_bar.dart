// import 'package:flutter/material.dart';
// import 'package:music_streaming_mobile/helper/common_import.dart';
//
// class DashboardNavigationBar extends StatefulWidget {
//   Function(MenuType)? menuSelectionHandler;
//   VoidCallback? languagePrefChangeBlock;
//   VoidCallback? loginCompletetionHandler;
//
//   DashboardNavigationBar(
//       {Key? key, this.menuSelectionHandler, this.languagePrefChangeBlock, this.loginCompletetionHandler})
//       : super(key: key);
//
//   @override
//   _DashboardNavigationBarState createState() => _DashboardNavigationBarState();
// }
//
// class _DashboardNavigationBarState extends State<DashboardNavigationBar> {
//   late Function(MenuType)? menuSelectionHandler;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     menuSelectionHandler = widget.menuSelectionHandler;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: AppTheme.singleton.primaryBackgroundColor.lighten(),
//       height: 80,
//       child: Row(
//         children: [
//           Responsive.isMobile(context)
//               ? ThemeIconWidget(
//                   ThemeIcon.menuIcon,
//                   color: AppTheme.singleton.lightColor,
//                 )
//               : Container(),
//           Row(
//             children: [
//               Container(
//                       height: 50,
//                       width: 50,
//                       color: AppTheme.singleton.themeColor.withOpacity(0.1),
//                       child: ThemeIconWidget(ThemeIcon.mic,
//                               color: AppTheme.singleton.lightColor)
//                           .p4)
//                   .circular,
//               const SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 'Music',
//                 style: TextStyles.titleMedium.redColor,
//               ),
//               Text(
//                 'y',
//                 style: TextStyles.titleMedium.lightColor,
//               ),
//             ],
//           ),
//           const Spacer(),
//           Responsive.isMobile(context)
//               ? Container()
//               : SizedBox(
//                   width:
//                       firebase_manager().auth.currentUser?.isAnonymous == true ||
//                               firebase_manager().auth.currentUser == null
//                           ? 430
//                           : 550,
//                   // child: menubar.PlutoMenuBar(
//                   //     backgroundColor:
//                   //         AppTheme.singleton.primaryBackgroundColor.darken(),
//                   //     borderColor:
//                   //         AppTheme.singleton.primaryBackgroundColor.darken(),
//                   //     menuIconColor:
//                   //         AppTheme.singleton.primaryBackgroundColor.darken(),
//                   //     moreIconColor:
//                   //         AppTheme.singleton.primaryBackgroundColor.darken(),
//                   //     gradient: false,
//                   //     textStyle: TextStyles.body.lightColor,
//                   //     menus: [
//                   //       menubar.MenuItem(
//                   //           title: LocalizationString.home,
//                   //           onTap: () {
//                   //             context.go('/');
//                   //
//                   //             if (menuSelectionHandler != null) {
//                   //               menuSelectionHandler!(MenuType.home);
//                   //             }
//                   //           }),
//                   //       if (firebase_manager().auth.currentUser?.isAnonymous ==
//                   //           false)
//                   //         menubar.MenuItem(
//                   //             title: LocalizationString.myMusic,
//                   //             children: [
//                   //               menubar.MenuItem(
//                   //                   title: LocalizationString.myPlaylist,
//                   //                   onTap: () {
//                   //                     context.go('/my-playlist');
//                   //
//                   //                     if (menuSelectionHandler != null) {
//                   //                       menuSelectionHandler!(
//                   //                           MenuType.myPlaylists);
//                   //                     }
//                   //                   }),
//                   //               menubar.MenuItem(
//                   //                   title: LocalizationString.likedSongs,
//                   //                   onTap: () {
//                   //                     context.go('/liked-songs');
//                   //
//                   //                     if (menuSelectionHandler != null) {
//                   //                       menuSelectionHandler!(
//                   //                           MenuType.likedSongs);
//                   //                     }
//                   //                   }),
//                   //               menubar.MenuItem(
//                   //                   title: LocalizationString.followedArtists,
//                   //                   onTap: () {
//                   //                     context.go('/followed-artists');
//                   //
//                   //                     if (menuSelectionHandler != null) {
//                   //                       menuSelectionHandler!(
//                   //                           MenuType.followedArtists);
//                   //                     }
//                   //                   }),
//                   //               menubar.MenuItem(
//                   //                   title: LocalizationString.followedPlaylists,
//                   //                   onTap: () {
//                   //                     context.go('/followed-playlist');
//                   //
//                   //                     if (menuSelectionHandler != null) {
//                   //                       menuSelectionHandler!(
//                   //                           MenuType.followedPlaylists);
//                   //                     }
//                   //                   }),
//                   //               menubar.MenuItem(
//                   //                   title: LocalizationString.downloadedSongs,
//                   //                   onTap: () {
//                   //                     showDialog(
//                   //                         context: context,
//                   //                         builder: (BuildContext context) {
//                   //                           return const DownloadSongPopup();
//                   //                         });
//                   //                     // if (menuSelectionHandler != null) {
//                   //                     //   menuSelectionHandler!(
//                   //                     //       MenuType.downloadedSongs);
//                   //                     // }
//                   //                   }),
//                   //             ]),
//                   //       menubar.MenuItem(
//                   //           title: LocalizationString.downloadApp,
//                   //           onTap: () {
//                   //             showDialog(
//                   //                 context: context,
//                   //                 builder: (BuildContext context) {
//                   //                   return const DownloadSongPopup();
//                   //                 });
//                   //           }),
//                   //       menubar.MenuItem(
//                   //           title: LocalizationString.language,
//                   //           onTap: () {
//                   //             showDialog(
//                   //                 context: context,
//                   //                 builder: (BuildContext context) {
//                   //                   return ChangeLanguage(
//                   //                     languagePrefChangeBlock:
//                   //                         widget.languagePrefChangeBlock,
//                   //                   );
//                   //                 });
//                   //             // if (menuSelectionHandler != null) {
//                   //             //   menuSelectionHandler!(
//                   //             //       MenuType.downloadedSongs);
//                   //             // }
//                   //           }),
//                   //       if (firebase_manager().auth.currentUser?.isAnonymous ==
//                   //               true ||
//                   //           firebase_manager().auth.currentUser == null)
//                   //         menubar.MenuItem(
//                   //             title: LocalizationString.signIn.toUpperCase(),
//                   //             onTap: () {
//                   //               signIn();
//                   //               // if (menuSelectionHandler != null){
//                   //               //   menuSelectionHandler!(MenuType.signIn);
//                   //               // }
//                   //             }),
//                   //       if (firebase_manager().auth.currentUser?.isAnonymous ==
//                   //           false)
//                   //         menubar.MenuItem(
//                   //             title: LocalizationString.myAccount,
//                   //             children: [
//                   //               menubar.MenuItem(
//                   //                   title:
//                   //                       'Mob - ${firebase_manager().auth.currentUser?.phoneNumber ?? ''}',
//                   //                   onTap: () {}),
//                   //               menubar.MenuItem(
//                   //                   title: LocalizationString.logout,
//                   //                   onTap: () {
//                   //                     firebase_manager().auth.signOut();
//                   //                     setState(() {});
//                   //                     context.go('/');
//                   //                   }),
//                   //             ])
//                   //     ]),
//                 )
//         ],
//       ).hP25,
//     ).round(20);
//   }
//
//   signIn() {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return LoginScreen(loginCompletedHandler: (){
//             setState(() {});
//             if (widget.loginCompletetionHandler != null){
//               widget.loginCompletetionHandler!();
//             }
//           },);
//         });
//   }
// }

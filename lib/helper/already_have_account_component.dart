// import 'package:flutter/material.dart';
// import 'package:music_streaming_mobile/helper/common_import.dart';
//
// class AlreadyHaveAccountComponent extends StatelessWidget {
//   final bool login;
//   final VoidCallback? onPress;
//   final TextStyle? textStyle;
//   final TextStyle? linkTextStyle;
//
//   const AlreadyHaveAccountComponent({
//     Key? key,
//     this.login = true,
//
//     this.onPress,
//     this.textStyle,
//     this.linkTextStyle,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Text(
//           login ? "Don’t have an Account ? " : "Already have an Account ? ",
//           style: textStyle ?? TextStyles.bodySm,
//         ),
//         GestureDetector(
//           onTap:onPress,
//           child: Text(
//             login ? "Sign Up" : "Sign In",
//             style: linkTextStyle ?? TextStyles.bodySm.bold,
//           ),
//         )
//       ],
//     );
//   }
// }

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';
import 'package:get/get.dart';
import 'package:music_streaming_mobile/screens/user/social_login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController enterEmail = TextEditingController();

  String phoneCode = '+1';
  final LoginController loginController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Image.asset(
            AppConfig.isDarkMode == true ? 'assets/images/bg.jpg' : 'assets/images/bg-light.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ThemeIconWidget(
                        ThemeIcon.backArrow,
                        color: Colors.white,
                        size: 25,
                      ).ripple(() {
                        Get.back();
                      }),

                    ],
                  ),


                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text(
                    LocalizationString.forgotPwd,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                       fontWeight: FontWeight.w600),
                  ),
                  Text(
                    LocalizationString.forgotPwdSubtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                height: 160,
                width: MediaQuery.of(context).size.width - 32,
                color: Theme.of(context).backgroundColor.withOpacity(0.55),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    InputField(
                      icon: ThemeIcon.email,
                      cornerRadius: 5,
                      hintText: 'adam@gmail.com',
                      controller: enterEmail,
                      onChanged: (phone) {},
                      showBorder: true,
                      backgroundColor: Colors.black.withOpacity(0.05),
                    ).hP4,
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: FilledButtonType1(
                        text: LocalizationString.submit,
                        enabledTextStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                        onPress: () {
                          forgotPassword();
                        },
                      ),
                    ),
                  ],
                ).hP16,
              )).round(20),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Theme.of(context).dividerColor,
                    height: 1,
                    width: 100,
                  ),
                  Text(
                    'Or connect using',
                    style: Theme.of(context).textTheme.titleSmall,
                  ).hP8,
                  Container(
                    color: Theme.of(context).dividerColor,
                    height: 1,
                    width: 100,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width - 32,
                      color: Theme.of(context).backgroundColor.withOpacity(0.55),
                      child: const SocialLogin()))
                  .round(20),
              const SizedBox(height: 20,),
              Column(
                children: [
                  Text(
                    LocalizationString.skip,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Theme.of(context).dividerColor,
                    height: 2,
                    width: 50,
                  ),
                ],
              ).ripple(() {
                getIt<UserProfileManager>().loginAnonymously();
              }),
              const SizedBox(
                height: 50,
              )
            ],
          ).hP16,
        ],
      ),
    );
  }

  forgotPassword() {
    if (enterEmail.text.isEmpty) {
      showMessage(LocalizationString.pleaseEnterPhone, true);
      return;
    }
    EasyLoading.show(status: LocalizationString.loading);

    loginController.resetPassword(enterEmail.text, (message) {
      showMessage(message, true);
    });
  }

  showMessage(String message, bool isError) {
    AppUtil.showToast(message: message, isSuccess: !isError);
  }
}

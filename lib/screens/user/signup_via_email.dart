import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';
import 'package:get/get.dart';
import 'package:music_streaming_mobile/screens/user/social_login.dart';

class SignupViaEmail extends StatefulWidget {
  const SignupViaEmail({Key? key}) : super(key: key);

  @override
  _SignupViaEmailState createState() => _SignupViaEmailState();
}

class _SignupViaEmailState extends State<SignupViaEmail> {
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController name = TextEditingController();

  TextEditingController signUpPassword = TextEditingController();

  final LoginController loginController = Get.find();

  String emailText = '';

  @override
  void initState() {
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
            AppConfig.isDarkMode == true
                ? 'assets/images/bg.jpg'
                : 'assets/images/bg-light.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
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
                      const SizedBox(
                        width: 25,
                      )
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text(
                    LocalizationString.signUp,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    LocalizationString.signUpMessage,
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
                    height: 300,
                    width: MediaQuery.of(context).size.width - 32,
                    color: Theme.of(context).backgroundColor.withOpacity(0.55),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        signUpView(),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 40,
                          child: FilledButtonType1(
                            text: LocalizationString.signUp,
                            enabledTextStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                            onPress: () {
                              signup();
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
              Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width - 32,
                      color:
                          Theme.of(context).backgroundColor.withOpacity(0.55),
                      child: const SocialLogin())
                  .round(20),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Text(
                    LocalizationString.skip,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
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

  Widget signUpView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputField(
            // key: UniqueKey(),
            controller: signUpEmail,
            hintText: "admin@gmail.com",
            icon: ThemeIcon.email,
            showBorder: true,
            cornerRadius: 5,
            backgroundColor: Colors.black.withOpacity(0.05),
          ),
          const SizedBox(
            height: 10,
          ),
          InputField(
            // key: UniqueKey(),
            controller: name,
            hintText: 'Adam',
            icon: ThemeIcon.account,
            showBorder: true,
            cornerRadius: 5,
            backgroundColor: Colors.black.withOpacity(0.05),
          ),
          const SizedBox(
            height: 10,
          ),
          PasswordField(
            onChanged: (txt) {},
            // key: UniqueKey(),
            controller: signUpPassword,
            hintText: '********',
            icon: ThemeIcon.lock,
            cornerRadius: 5,
            showBorder: true,
            backgroundColor: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
    );
  }

  resetPassword() {
    EasyLoading.show(status: LocalizationString.loading);

    loginController.resetPassword(emailText, (message) {
      showMessage(message, true);
    });
  }

  signup() {
    if (signUpEmail.text.isEmpty) {
      showMessage(LocalizationString.pleaseEnterValidEmail, true);
      return;
    } else if (signUpEmail.text.isValidEmail() == false) {
      showMessage(LocalizationString.pleaseEnterValidEmail, true);
      return;
    } else if (signUpPassword.text.isEmpty) {
      showMessage(LocalizationString.pleaseEnterPassword, true);
      return;
    }

    EasyLoading.show(status: LocalizationString.loading);

    loginController.signUpViaEmail(
        email: signUpEmail.text,
        password: signUpPassword.text,
        name: name.text,
        completion: (error) async {
          await getIt<UserProfileManager>().refreshProfile();

          EasyLoading.dismiss();
          if (error == null) {
            Get.offAll(() => const MainScreen());
          } else {
            showMessage(error, true);
          }
        });
  }

  showMessage(String message, bool isError) {
    AppUtil.showToast(message: message, isSuccess: !isError);
  }
}

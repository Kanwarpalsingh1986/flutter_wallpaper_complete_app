import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  final LoginController loginController = Get.find();

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
                    LocalizationString.changePwd,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    LocalizationString.changePwdMessage,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    height: 230,
                    width: MediaQuery.of(context).size.width - 32,
                    color: Theme.of(context).backgroundColor.withOpacity(0.55),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        changePasswordView(),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 40,
                          child: FilledButtonType1(
                            text: LocalizationString.changePwd,
                            enabledTextStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                            onPress: () {
                              changePassword();
                            },
                          ),
                        ),
                      ],
                    ).hP16,
                  )).round(20),
              const Spacer(),
            ],
          ).hP16,
        ],
      ),
    );
  }

  Widget changePasswordView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PasswordField(
            onChanged: (txt) {},
            controller: newPassword,
            hintText: '********',
            icon: ThemeIcon.lock,
            cornerRadius: 5,
            showBorder: true,
            backgroundColor: Colors.black.withOpacity(0.05),
          ),
          const SizedBox(
            height: 10,
          ),
          PasswordField(
            onChanged: (txt) {},
            controller: confirmNewPassword,
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

  changePassword() {
    if (newPassword.text.isEmpty) {
      showMessage(LocalizationString.pleaseEnterPassword, true);
      return;
    } else if (confirmNewPassword.text.isValidEmail() == false) {
      showMessage(LocalizationString.pleaseEnterConfirmPassword, true);
      return;
    } else if (newPassword.text != confirmNewPassword.text) {
      showMessage(LocalizationString.passwordsDoesNotMatched, true);
      return;
    }

    EasyLoading.show(status: LocalizationString.loading);

    loginController.changePassword(newPassword.text, (callbackMessage) {
      if (callbackMessage == null) {
        Get.off(const AskForLogin());
      } else {
        showMessage(callbackMessage, true);
      }
    });
  }

  showMessage(String message, bool isError) {
    AppUtil.showToast(message: message, isSuccess: !isError);
  }
}

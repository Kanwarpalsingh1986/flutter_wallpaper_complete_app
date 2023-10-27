import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';
import 'package:get/get.dart';
import 'package:music_streaming_mobile/screens/user/social_login.dart';

//ignore: must_be_immutable
class VerifyOTP extends StatefulWidget {
  String verificationId;
  final String phone;

  VerifyOTP({Key? key, required this.verificationId, required this.phone})
      : super(key: key);

  @override
  VerifyOTPState createState() => VerifyOTPState();
}

class VerifyOTPState extends State<VerifyOTP> {
  TextEditingController otp = TextEditingController();

  bool wrongOTP = false;
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
            AppConfig.isDarkMode == true
                ? 'assets/images/bg.jpg'
                : 'assets/images/bg-light.jpg',
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
                    LocalizationString.enterOTP,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    LocalizationString.enterOtpMessage,
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
                        PasswordField(
                          cornerRadius: 5,
                          icon: ThemeIcon.otp,
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                          hintText: LocalizationString.enterOTP,
                          controller: otp,
                          showBorder: true,
                          backgroundColor: Colors.black.withOpacity(0.05),
                          onChanged: (phone) {},
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
                              submitOTP();
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
                          color: Theme.of(context)
                              .backgroundColor
                              .withOpacity(0.55),
                          child: const SocialLogin()))
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
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ).hP16,
        ],
      ),
    );
  }

  submitOTP() {
    if (otp.text.isEmpty) {
      showMessage(LocalizationString.pleaseEnterOTP, true);
      return;
    }
    // EasyLoading.show(status: LocalizationString.loading);

    // EasyLoading.show(status: LocalizationString.loading);

    loginController.submitOTP(otp.text, widget.verificationId, (error) async {
      // EasyLoading.dismiss();
      if (error == null) {
        Get.to(() => const MainScreen());
      } else {
        showMessage(error, true);
      }
    });
  }

  resendOTP() {
    EasyLoading.show(status: LocalizationString.loading);
    loginController.sendOTP(
        phone: widget.phone,
        successCompletion: (id) {
          EasyLoading.dismiss();
          widget.verificationId = id;
        },
        errorHandler: (error) {
          showMessage(error, true);
        });
  }

  showMessage(String message, bool isError) {
    AppUtil.showToast(message: message, isSuccess: !isError);
  }
}

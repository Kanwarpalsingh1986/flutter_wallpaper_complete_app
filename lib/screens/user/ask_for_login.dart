import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';
import 'package:get/get.dart';
import 'package:music_streaming_mobile/screens/user/social_login.dart';

class AskForLogin extends StatefulWidget {
  const AskForLogin({Key? key}) : super(key: key);

  @override
  State<AskForLogin> createState() => _AskForLoginState();
}

class _AskForLoginState extends State<AskForLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Text(
                AppConfig.projectName,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width - 32,
                  color: Theme.of(context).backgroundColor.withOpacity(0.55),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            LocalizationString.welcome,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            LocalizationString.welcomeSubtitleMsg,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 40,
                            child: FilledButtonType1(
                              text: LocalizationString.signIn,
                              enabledTextStyle:
                                  Theme.of(context).textTheme.titleMedium,
                              onPress: () {
                                Get.to(() => const LoginViaEmail());
                              },
                            ),
                          ).hP16,
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 40,
                            child: BorderButtonType1(
                              text: LocalizationString.signUp,
                              textStyle:
                                  Theme.of(context).textTheme.titleMedium,
                              onPress: () {
                                Get.to(() => const SignupViaEmail());
                              },
                            ),
                          ).hP16,
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: Theme.of(context).dividerColor,
                                height: 1,
                                width: 50,
                              ),
                              Text(
                                'Or connect using',
                                style: Theme.of(context).textTheme.titleSmall,
                              ).hP8,
                              Container(
                                color: Theme.of(context).dividerColor,
                                height: 1,
                                width: 50,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const SocialLogin(),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )),
                ).round(20),
              ),
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
              })
            ],
          ).hP16,
        ],
      ),
    );
  }
}

import 'package:ai_app/core/constants/constants.dart';
import 'package:ai_app/core/managers/asset_manager.dart';
import 'package:ai_app/features/auth/presentation/view/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class GetStartedViewBody extends StatelessWidget {
  const GetStartedViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Lottie.asset(
            height: size.height,
            AnimationManager.background,
            fit: BoxFit.fill,
          ),
          Positioned(
              top: 120,
              left: 30,
              child: Column(
                children: [
                  const Text(
                    'EXPLORE OUR \nNEW AI !',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
                  ).animate().fadeIn(duration: kDuration),
                ],
              )),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: InkWell(
              onTap: () {
                Get.to(const SignInView(), transition: Transition.fadeIn);
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                ),
              ).animate().slideY(
                    duration: const Duration(seconds: 2),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

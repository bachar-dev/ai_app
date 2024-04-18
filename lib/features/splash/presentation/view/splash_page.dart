import 'dart:async';
import 'package:ai_app/core/constants/constants.dart';
import 'package:ai_app/features/auth/presentation/view/get_started.dart';
import 'package:ai_app/features/splash/presentation/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;
  _startDelay() {
    _timer = Timer(kDuration, _goNext);
  }

  _goNext() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const GetStartedView()));
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashViewBody(),
    );
  }
}

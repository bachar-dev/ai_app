// ignore_for_file: use_build_context_synchronously

import 'package:ai_app/core/managers/asset_manager.dart';
import 'package:ai_app/features/home/presentation/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Lottie.asset(
                height: size.height,
                AnimationManager.background,
                fit: BoxFit.fill,
              ),
              Positioned(
                  top: 120,
                  left: 20,
                  child: Column(
                    children: [
                      const Text(
                        'Welcome back! you\'ve\nbeen missed',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      SizedBox(
                          width: 300,
                          height: 70,
                          child: TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                                hintText: "enter your email",
                                border: OutlineInputBorder()),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 300,
                        height: 70,
                        child: TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                              hintText: "enter your password",
                              border: OutlineInputBorder()),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () async {
                          try {
                            await Supabase.instance.client.auth
                                .signInWithPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          } catch (e) {
                            if (kDebugMode) {
                              print(e.toString());
                            }
                          }
                        },
                        child: Container(
                          height: 60,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text('LOGIN'),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

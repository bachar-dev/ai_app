import 'package:ai_app/core/managers/asset_manager.dart';
import 'package:ai_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
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
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      LoginEvent(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                    );
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
    );
  }
}

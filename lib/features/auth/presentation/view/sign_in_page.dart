// ignore_for_file: use_build_context_synchronously
import 'package:ai_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:ai_app/features/auth/presentation/widgets/sign_in_view_body.dart';
import 'package:ai_app/features/home/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocListener<AuthBloc, Auth1State>(
          listener: (context, state) {
            if (state is LoadingState) {
              isLoading = true;
            }
            if (state is SuccessState) {
              isLoading = false;
              Get.to(() => const HomePage());
            }
            if (state is FailureState) {
              isLoading = false;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          child: Center(
            child: ModalProgressHUD(
              inAsyncCall: isLoading,
              child: SignInViewBody(
                emailController: _emailController,
                passwordController: _passwordController,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

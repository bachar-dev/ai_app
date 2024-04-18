import 'package:ai_app/features/auth/presentation/widgets/get_started_view_body.dart';
import 'package:flutter/material.dart';

class GetStartedView extends StatefulWidget {
  const GetStartedView({super.key});

  @override
  State<GetStartedView> createState() => _GetStartedViewState();
}

class _GetStartedViewState extends State<GetStartedView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GetStartedViewBody(),
    );
  }
}

import 'package:ai_app/app/app.dart';
import 'package:ai_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://otckspuneteyxksreymo.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im90Y2tzcHVuZXRleXhrc3JleW1vIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI3NDkzNzksImV4cCI6MjAyODMyNTM3OX0.pQrWGhDB7GFxTX3jPcUujCjCEpZFMXvjbOUCqDG-tQE");
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(),
      child: const MyApp(),
    ),
  );
}

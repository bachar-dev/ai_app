// ignore_for_file: missing_required_param
import 'package:ai_app/features/auth/presentation/view/get_started.dart';
import 'package:ai_app/helper/api.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:record/record.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Record record;
  bool isRecording = false;
  late AudioPlayer audio;
  String? audioPath;
  @override
  initState() {
    record = Record();
    audio = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    record.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    try {
      if (await record.hasPermission()) {
        await record.start(encoder: AudioEncoder.wav);

        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('errror recording:$e');
      }
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await record.stop();
      print('$path');
      Api api = Api();

      var response = await api.postWithAudio(
          url: 'http://192.168.0.106:5000/predict', path: path!);

      if (kDebugMode) {
        print(response);
      }
      setState(() {
        isRecording = false;
        audioPath = path;
      });

      if (kDebugMode) {
        print('$audioPath');
      }
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    }
  }

  Future<void> startPlaying() async {
    try {
      audio.play(UrlSource(audioPath!));
    } catch (e) {
      print('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: isRecording ? stopRecording : startRecording,
              child: isRecording == true
                  ? const Text('stop recoding')
                  : const Text('Start Recording'),
            ),
            TextButton(
              onPressed: audioPath != null ? startPlaying : () {},
              child: const Text('play'),
            ),
            TextButton(
              onPressed: () {
                Supabase.instance.client.auth.signOut();

                Get.toEnd(() => const GetStartedView());
              },
              child: const Text('log out'),
            ),
          ],
        ),
      ),
    );
  }
}

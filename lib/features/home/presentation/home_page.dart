import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

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
  void initState() {
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
        await record.start();

        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      print('errror recording:$e');
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await record.stop();

      setState(() {
        isRecording = false;
        audioPath = path;
      });

      print('$audioPath');
    } catch (e) {
      print('$e');
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
          ],
        ),
      ),
    );
  }
}

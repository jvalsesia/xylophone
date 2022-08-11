import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AudioApp();
  }
}

class AudioApp extends StatefulWidget {
  const AudioApp({Key? key}) : super(key: key);

  @override
  State<AudioApp> createState() => _AudioAppState();
}

class ToneBar {
  int id;
  Color color;
  bool visibleIcon;

  ToneBar(this.id, this.color, this.visibleIcon);
}

class _AudioAppState extends State<AudioApp> {
  List<ToneBar> toneBars = [
    ToneBar(1, Colors.red, false),
    ToneBar(2, Colors.orange, false),
    ToneBar(3, Colors.yellow, false),
    ToneBar(4, Colors.green, false),
    ToneBar(5, Colors.teal, false),
    ToneBar(6, Colors.blue, false),
    ToneBar(7, Colors.purple, false)
  ];

  Future<void> _playTone(ToneBar toneBar) async {
    setState(() {
      toneBar.visibleIcon = true;
    });
    final player = AudioPlayer();
    player.onPlayerComplete.listen((event) {
      player.release();
      setState(() {
        toneBar.visibleIcon = false;
      });
    });
    await player.play(AssetSource('note${toneBar.id}.wav'));
  }

  Widget _addToneBar(ToneBar toneBar) {
    return Expanded(
      child: Card(
        color: toneBar.color,
        child: TextButton(
          onPressed: () async {
            _playTone(toneBar);
          },
          child: Icon(
            Icons.audiotrack,
            color: toneBar.visibleIcon ? Colors.black : toneBar.color,
            size: 30.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (ToneBar toneBar in toneBars) _addToneBar(toneBar),
            ],
          ),
        ),
      ),
    );
  }
}

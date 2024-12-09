import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MaterialApp(home: S()));

class S extends StatefulWidget {
  const S({super.key});

  @override
  State<S> createState() => _SState();
}

class _SState extends State<S> {
  VideoPlayerController? vidio;

  @override
  void initState() {
    super.initState();
    // Video controller'ni ishga tushirish
    vidio = VideoPlayerController.asset('video/land.mp4')
      ..initialize().then((_) {
        setState(() {}); // Video initialized bo'lgandan keyin UI yangilash
      });
  }

  @override
  void dispose() {
    vidio?.dispose(); // Controller'ni to'g'ri yopish
    super.dispose();
  }

  void f() {
    if (vidio != null && vidio!.value.isInitialized) {
      setState(() {
        // Agar video o'ynayotgan bo'lsa, pauza qiling, aks holda o'ynating
        vidio!.value.isPlaying ? vidio!.pause() : vidio!.play();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: f,
        child: Icon(
          vidio != null && vidio!.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
        ),
      ),
      body: Center(
        child: vidio != null && vidio!.value.isInitialized
            ? AspectRatio(
                aspectRatio: vidio!.value.aspectRatio,
                child: VideoPlayer(vidio!),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}

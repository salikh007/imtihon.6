import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: S()));

class S extends StatefulWidget {
  const S({super.key});

  @override
  State<S> createState() => _SState();
}

class _SState extends State<S> {
  VideoPlayerController? vidio1;
  VideoPlayerController? vidio2;
  VideoPlayerController? vidio3;
  VideoPlayerController? vidio4;

  @override
  void initState() {
    super.initState();
    vidio1 = VideoPlayerController.asset('vidio/manz.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    vidio2 = VideoPlayerController.asset('vidio/asd.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    vidio3 = VideoPlayerController.asset('vidio/as.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    vidio4 = VideoPlayerController.asset('vidio/a.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    vidio1?.dispose();
    vidio2?.dispose();
    vidio3?.dispose();
    vidio4?.dispose();
    super.dispose();
  }

  void toggleVideo(VideoPlayerController? controller) {
    if (controller != null && controller.value.isInitialized) {
      setState(() {
        controller.value.isPlaying ? controller.pause() : controller.play();
      });
    }
  }

  Widget buildVideoPlayer(VideoPlayerController? controller) {
    return controller != null && controller.value.isInitialized
        ? FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: controller.value.size.width,
              height: controller.value.size.height,
              child: VideoPlayer(controller),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () => toggleVideo(vidio1),
            child: Icon(
              vidio1 != null && vidio1!.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => toggleVideo(vidio2),
            child: Icon(
              vidio2 != null && vidio2!.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => toggleVideo(vidio3),
            child: Icon(
              vidio3 != null && vidio3!.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => toggleVideo(vidio4),
            child: Icon(
              vidio4 != null && vidio4!.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(child: buildVideoPlayer(vidio1)),
                Expanded(child: buildVideoPlayer(vidio2)),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(child: buildVideoPlayer(vidio3)),
                Expanded(child: buildVideoPlayer(vidio4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

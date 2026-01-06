import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LiveCameraPlayer extends StatefulWidget {
  final String streamUrl;
  final String title;

  const LiveCameraPlayer({
    super.key,
    required this.streamUrl,
    required this.title,
  });

  @override
  State<LiveCameraPlayer> createState() => _LiveCameraPlayerState();
}

class _LiveCameraPlayerState extends State<LiveCameraPlayer> {
  late VideoPlayerController _controller;
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.streamUrl),
    )
      ..initialize().then((_) {
        setState(() {
          _loading = false;
          _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: _loading
                ? 16 / 9
                : _controller.value.aspectRatio,
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : VideoPlayer(_controller),
          ),

          /// CAMERA INFO
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.black,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'LIVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

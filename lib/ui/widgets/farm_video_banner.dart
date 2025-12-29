import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../common/app_colors.dart';

class FarmVideoBanner extends StatefulWidget {
  final String videoUrl;

  const FarmVideoBanner({
    super.key,
    required this.videoUrl,
  });

  @override
  State<FarmVideoBanner> createState() => _FarmVideoBannerState();
}

class _FarmVideoBannerState extends State<FarmVideoBanner> {
  late VideoPlayerController _controller;
  bool isMuted = true;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller
          ..setLooping(true)
          ..setVolume(0) // 🔇 start muted
          ..play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// ▶ Play / Pause on tap
  void _togglePlayPause() {
    setState(() {
      _controller.value.isPlaying
          ? _controller.pause()
          : _controller.play();
    });
  }

  /// 🔊 Mute / Unmute
  void _toggleMute() {
    setState(() {
      isMuted = !isMuted;
      _controller.setVolume(isMuted ? 0 : 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: _controller.value.isInitialized
            ? GestureDetector(
          onTap: _togglePlayPause,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),

              /// ▶ Play icon when paused
              if (!_controller.value.isPlaying)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
                  ),
                ),

              /// 🔊 Mute / Unmute button
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: _toggleMute,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isMuted ? Icons.volume_off : Icons.volume_up,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
            : const SizedBox(
          height: 200,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

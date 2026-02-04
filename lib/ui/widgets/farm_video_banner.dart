// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class FarmVideoBanner extends StatefulWidget {
//   final String videoUrl;
//
//   const FarmVideoBanner({
//     super.key,
//     required this.videoUrl,
//   });
//
//   @override
//   State<FarmVideoBanner> createState() => _FarmVideoBannerState();
// }
//
// class _FarmVideoBannerState extends State<FarmVideoBanner> {
//   late VideoPlayerController _controller;
//   bool isMuted = true;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = VideoPlayerController.networkUrl(
//       Uri.parse(widget.videoUrl),
//     )
//       ..initialize().then((_) {
//         setState(() {});
//         _controller
//           ..setLooping(true)
//           ..setVolume(0); // 🔇 muted
//         // ❌ DO NOT play here (starts paused)
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   /// ▶ Play / Pause
//   void _togglePlayPause() {
//     setState(() {
//       _controller.value.isPlaying
//           ? _controller.pause()
//           : _controller.play();
//     });
//   }
//
//   /// 🔊 Mute / Unmute
//   void _toggleMute() {
//     setState(() {
//       isMuted = !isMuted;
//       _controller.setVolume(isMuted ? 0 : 1);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final reelHeight = MediaQuery
//         .of(context)
//         .size
//         .height * 0.55;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(24),
//         child: _controller.value.isInitialized
//             ? GestureDetector(
//           onTap: _togglePlayPause,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               SizedBox(
//                 height: reelHeight,
//                 width: double.infinity,
//                 child: FittedBox(
//                   fit: BoxFit.cover,
//                   child: SizedBox(
//                     width: _controller.value.size.width,
//                     height: _controller.value.size.height,
//                     child: VideoPlayer(_controller),
//                   ),
//                 ),
//               ),
//
//               /// ▶ Play icon (initially visible)
//               if (!_controller.value.isPlaying)
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.black.withValues(alpha: 0.4),
//                     shape: BoxShape.circle,
//                   ),
//                   padding: const EdgeInsets.all(14),
//                   child: const Icon(
//                     Icons.play_arrow,
//                     color: Colors.white,
//                     size: 44,
//                   ),
//                 ),
//
//               /// 🔊 Volume
//               Positioned(
//                 top: 16,
//                 right: 16,
//                 child: GestureDetector(
//                   onTap: _toggleMute,
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withValues(alpha: 0.4),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       isMuted
//                           ? Icons.volume_off
//                           : Icons.volume_up,
//                       color: Colors.white,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )
//             : SizedBox(
//           height: reelHeight,
//           child: const Center(child: CircularProgressIndicator()),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    )
      ..initialize().then((_) {
        setState(() {});
        _controller
          ..setLooping(true)
          ..setVolume(0); // start muted
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _controller.value.isPlaying
          ? _controller.pause()
          : _controller.play();
    });
  }

  void _toggleMute() {
    setState(() {
      isMuted = !isMuted;
      _controller.setVolume(isMuted ? 0 : 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double bannerWidth = MediaQuery.of(context).size.width - 32;
    final double bannerHeight = bannerWidth * (524 / 339); // Figma ratio

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: bannerWidth,
        height: bannerHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40), // Figma radius
          child: _controller.value.isInitialized
              ? Stack(
            children: [

              /// 🎬 VIDEO BACKGROUND
              Positioned.fill(
                child: GestureDetector(
                  onTap: _togglePlayPause,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
              ),

              /// ▶ Center Play Icon (if paused)
              if (!_controller.value.isPlaying)
                Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),

              /// 🔊 + ▶ Controls Bottom Right (Figma style)
              Positioned(
                right: 20,
                bottom: 20,
                child: Row(
                  children: [

                    /// Mute Button
                    _roundControlButton(
                      icon: isMuted
                          ? Icons.volume_off
                          : Icons.volume_up,
                      onTap: _toggleMute,
                    ),

                    const SizedBox(width: 12),

                    /// Play/Pause Button
                    _roundControlButton(
                      icon: _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      onTap: _togglePlayPause,
                    ),
                  ],
                ),
              ),
            ],
          )
              : const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Widget _roundControlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.4),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}

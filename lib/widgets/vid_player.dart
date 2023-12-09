import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({
    super.key,
    required this.url,
    required this.dataSourceType,
  });

  final String url;

  final DataSourceType dataSourceType;

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  VideoPlayerController? _videoPlayerController;

  ChewieController? _chewieController;

  @override
  void initState() {
    if (mounted) {
      super.initState();

      switch (widget.dataSourceType) {
        case DataSourceType.asset:
          _videoPlayerController = VideoPlayerController.asset(widget.url);
          break;
        case DataSourceType.network:
          _videoPlayerController =
              VideoPlayerController.networkUrl(Uri.parse(widget.url));
          break;
        case DataSourceType.file:
          _videoPlayerController = VideoPlayerController.file(File(widget.url));
          break;
        case DataSourceType.contentUri:
          _videoPlayerController =
              VideoPlayerController.contentUri(Uri.parse(widget.url));
          break;
      }

      _videoPlayerController!.initialize().then(
            (_) => mounted
                ? setState(
                    () => _chewieController = ChewieController(
                      materialProgressColors: ChewieProgressColors(
                        playedColor: Colors.amber,
                        bufferedColor: Colors.amber.withOpacity(0.2),
                      ),
                      allowFullScreen: false,
                      videoPlayerController: _videoPlayerController!,
                      aspectRatio: 16 / 9,
                    ),
                  )
                : null,
          );
    }
  }

  @override
  void dispose() {
    if (_chewieController != null && _videoPlayerController != null) {
      _videoPlayerController!.dispose();
      _chewieController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null && _videoPlayerController != null
        ? AspectRatio(
            aspectRatio: 16 / 9,
            child: Chewie(controller: _chewieController!),
          )
        : AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              ),
            ));
  }
}

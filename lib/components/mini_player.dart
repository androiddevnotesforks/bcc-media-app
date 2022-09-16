import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/providers/chromecast.dart';
import 'package:my_app/providers/playback_api.dart';
import 'package:my_app/providers/video_state.dart';
import 'package:my_app/router/router.gr.dart';
import 'package:transparent_image/transparent_image.dart';

class MiniPlayer extends ConsumerStatefulWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends ConsumerState<MiniPlayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Player? player;
    if (ref.watch(isCasting)) {
      player = ref.watch(castPlayerProvider);
    } else {
      player = ref.watch(primaryPlayerProvider);
    }

    if (player == null || player.currentMediaItem == null) {
      return SizedBox.shrink();
    }

    var artist = player.currentMediaItem?.metadata?.artist;
    var title = player.currentMediaItem?.metadata?.title;
    var artworkUri = player.currentMediaItem?.metadata?.artworkUri;
    var playbackState = player.playbackState;

    return GestureDetector(
      onTap: () {
        var episodeId = player!.currentMediaItem?.metadata?.episodeId;
        var isLivestream = player!.currentMediaItem?.metadata?.extras?['id'] == 'livestream';
        if (episodeId != null) {
          context.router.push(EpisodeScreenRoute(episodeId: episodeId));
        } else if (isLivestream) {
          context.router.navigate(const LiveScreenRoute());
        }
      },
      child: _MiniPlayer(
        artist: artist ?? 'Artist missing',
        title: title ?? 'Title missing',
        artworkUri:
            artworkUri ?? 'https://source.unsplash.com/random/1600x900/?fruit',
        isPlaying: playbackState == PlaybackState.playing,
        onPlayTap: () {
          ref.read(playbackApiProvider).play(player!.playerId);
        },
        onPauseTap: () {
          ref.read(playbackApiProvider).pause(player!.playerId);
        },
        onCloseTap: () {
          ref.read(playbackApiProvider).stop(player!.playerId, true);
        },
      ),
    );
  }
}

class _MiniPlayer extends StatelessWidget {
  final String artist;
  final String title;
  final String artworkUri;
  final bool isPlaying;
  final void Function()? onPauseTap;
  final void Function()? onPlayTap;
  final void Function()? onCloseTap;

  const _MiniPlayer({
    Key? key,
    required this.artist,
    required this.title,
    required this.artworkUri,
    required this.isPlaying,
    this.onPauseTap,
    this.onPlayTap,
    this.onCloseTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Color(0xff1d2838),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 64,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Color(0x19ffffff),
                width: 1,
              ),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  fit: BoxFit.fill,
                  artworkUri,
                  width: 64,
                  height: 36,
                )),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  artist,
                  style: TextStyle(
                    color: Color(0xff6eb0e6),
                    fontSize: 12,
                    fontFamily: 'Barlow',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xfffefefe),
                      fontSize: 14,
                      fontFamily: 'Barlow',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => isPlaying ? onPauseTap?.call() : onPlayTap?.call(),
            child: Container(
              margin: EdgeInsets.only(left: 16),
              height: 36,
              child: isPlaying
                  ? Image.asset(
                      height: 24,
                      'assets/icons/Pause.png',
                      gaplessPlayback: true)
                  : Image.asset(
                      height: 24,
                      'assets/icons/Play.png',
                      gaplessPlayback: true),
            ),
          ),
          GestureDetector(
            onTap: () => onCloseTap?.call(),
            child: Container(
              margin: EdgeInsets.only(left: 7),
              height: 36,
              child: Image.asset(
                  width: 32,
                  height: 16,
                  'assets/icons/Close.png',
                  gaplessPlayback: true),
            ),
          ),
        ],
      ),
    );
  }
}
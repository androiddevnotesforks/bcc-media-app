import 'package:auto_route/auto_route.dart';
import 'package:bccm_player/playback_platform_pigeon.g.dart';
import 'package:brunstadtv_app/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:brunstadtv_app/providers/chromecast.dart';
import 'package:brunstadtv_app/providers/playback_api.dart';
import 'package:brunstadtv_app/providers/video_state.dart';
import 'package:brunstadtv_app/router/router.gr.dart';

import '../helpers/btv_colors.dart';
import '../providers/fun.dart';
import 'mini_player.dart';

class BottomSheetMiniPlayer extends ConsumerStatefulWidget {
  const BottomSheetMiniPlayer({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomSheetMiniPlayerState();
}

class _BottomSheetMiniPlayerState extends ConsumerState<BottomSheetMiniPlayer> {
  MediaMetadata? previousMetadata;

  @override
  Widget build(BuildContext context) {
    Player? player;
    if (ref.watch(isCasting)) {
      player = ref.watch(castPlayerProvider);
    } else {
      player = ref.watch(primaryPlayerProvider);
    }
    if (previousMetadata != player?.currentMediaItem?.metadata) {
      WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
            previousMetadata = player?.currentMediaItem?.metadata;
          }));
    }

    bool hideMiniPlayer = _shouldHideMiniPlayer(player, context.watchRouter);

    return AnimatedAlign(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutQuart,
        alignment: Alignment.topCenter,
        heightFactor: hideMiniPlayer ? 0 : 1,
        child: hideMiniPlayer || player == null
            ? _buildDummy()
            : _buildMiniPlayer(player));
  }

  Widget _buildMiniPlayer(Player player) {
    var artist = player.currentMediaItem?.metadata?.artist;
    var title = player.currentMediaItem?.metadata?.title;
    var artworkUri = player.currentMediaItem?.metadata?.artworkUri;
    var playbackState = player.playbackState;

    return GestureDetector(
      onTap: () {
        var id =
            player.currentMediaItem?.metadata?.extras?['id'].asOrNull<String>();
        if (id == 'livestream') {
          context.router.navigate(const LiveScreenRoute());
        } else if (id != null) {
          ref.read(tempTitleProvider.notifier).state = title;
          try {
            context.navigateTo(EpisodeScreenRoute(episodeId: id));
          } catch (_) {
            context.navigateTo(HomeScreenWrapperRoute(
                children: [EpisodeScreenRoute(episodeId: id)]));
          }
        }
      },
      child: MiniPlayer(
        secondaryTitle: artist,
        title: title ?? '',
        artworkUri:
            artworkUri ?? 'https://source.unsplash.com/random/1600x900/?fruit',
        isPlaying: playbackState == PlaybackState.playing,
        onPlayTap: () {
          ref.read(playbackApiProvider).play(player.playerId);
        },
        onPauseTap: () {
          ref.read(playbackApiProvider).pause(player.playerId);
        },
        onCloseTap: () {
          ref.read(playbackApiProvider).stop(player.playerId, true);
        },
      ),
    );
  }

  /// Builds based on the previous meta (to ensure smooth transition)
  /// Worst case, just a blank box. Shouldn't happen though, I think.
  Widget _buildDummy() {
    if (previousMetadata != null) {
      var artist = previousMetadata!.artist;
      var title = previousMetadata!.title;
      var artworkUri = previousMetadata!.artworkUri;
      return MiniPlayer(
          secondaryTitle: artist,
          title: title ?? '',
          artworkUri: artworkUri ??
              'https://source.unsplash.com/random/1600x900/?fruit',
          isPlaying: false);
    }
    return Container(
        height: kMiniPlayerHeight,
        width: MediaQuery.of(context).size.width,
        color: BtvColors.background2,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ));
  }

  bool _shouldHideMiniPlayer(Player? player, StackRouter router) {
    if (player == null || player.currentMediaItem == null) {
      return true;
    }
    if (router.currentSegments.last.meta.containsKey('hide_mini_player')) {
      return true;
    }
    if (player.isInPipMode) {
      return true;
    }

    final currentEpisodePageArgs = (router.currentSegments.last.args as Object?)
        .asOrNull<EpisodeScreenRouteArgs>();

    if (currentEpisodePageArgs?.autoplay == true) {
      return true;
    }

    final episodeId =
        player.currentMediaItem?.metadata?.extras?['id']?.asOrNull<String>();

    if (episodeId != null &&
        currentEpisodePageArgs != null &&
        currentEpisodePageArgs.episodeId == episodeId) {
      return true;
    }
    return false;
  }
}
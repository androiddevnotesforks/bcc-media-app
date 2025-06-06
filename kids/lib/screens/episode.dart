import 'package:auto_route/auto_route.dart';
import 'package:bccm_core/bccm_core.dart';
import 'package:bccm_player/bccm_player.dart';
import 'package:bccm_player/controls.dart';
import 'package:bccm_core/platform.dart';
import 'package:brunstadtv_app/providers/playback_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kids/components/player/player_view.dart';
import 'package:kids/helpers/svg_icons.dart';
import 'package:kids/helpers/transitions.dart';

@RoutePage()
class EpisodeScreen extends HookConsumerWidget {
  const EpisodeScreen({
    super.key,
    @PathParam('episodeId') required this.id,
    @QueryParam() this.shuffle,
    @QueryParam() this.playlistId,
    @QueryParam() this.cursor,
  });

  final String id;
  final bool? shuffle;
  final String? cursor;
  final String? playlistId;

  bool get episodeIsCurrentItem => BccmPlayerController.primary.value.currentMediaItem?.metadata?.extras?['id'] == id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gqlClient = ref.watch(bccmGraphQLProvider);

    fetchEpisode() async => gqlClient.query$KidsFetchEpisode(Options$Query$KidsFetchEpisode(
          variables: Variables$Query$KidsFetchEpisode(
            id: id,
            context: Input$EpisodeContext(
              shuffle: shuffle ?? false,
              cursor: cursor,
              playlistId: playlistId,
            ),
          ),
        ));

    final episodeFuture = useState(useMemoized(fetchEpisode));

    void onDispose() {
      if (BccmPlayerController.primary.value.currentMediaItem != null && episodeIsCurrentItem) {
        if (BccmPlayerController.primary.isChromecast) return;
        BccmPlayerController.primary.pause();
      }
    }

    useEffect(() {
      episodeFuture.value = fetchEpisode();
      return onDispose;
    }, [id, shuffle, playlistId, cursor]);

    final episodeSnapshot = useFuture(episodeFuture.value);
    final episodeData = episodeSnapshot.data?.parsedData?.episode;
    final playbackService = ref.watch(playbackServiceProvider);
    final firstLoadDone = useState(false);
    final currentId = useState(BccmPlayerController.primary.value.currentMediaItem?.metadata?.extras?['id']);
    final morphTransition = InheritedData.watch<MorphTransitionInfo>(context);

    useEffect(() {
      void listener() {
        currentId.value = BccmPlayerController.primary.value.currentMediaItem?.metadata?.extras?['id'];
      }

      BccmPlayerController.primary.addListener(listener);
      return () {
        BccmPlayerController.primary.removeListener(listener);
      };
    });

    final transitionDone = useState(false);

    useEffect(() {
      if (episodeData != null && !episodeIsCurrentItem) {
        final duration = morphTransition?.duration ?? 0.ms;
        Future.delayed(duration - 100.ms, () {
          if (!context.mounted) return;
          transitionDone.value = true;
          playbackService.playEpisode(
            playerId: BccmPlayerController.primary.value.playerId,
            episode: episodeData,
            autoplay: true,
            playlistId: playlistId,
          );
        });
        firstLoadDone.value = true;
      }
      return () {};
    }, [episodeData]);

    final viewController = useMemoized(
        () => BccmPlayerViewController(
              playerController: BccmPlayerController.primary,
              config: BccmPlayerViewConfig(
                castPlayerBuilder: (context) => DefaultCastPlayer(
                  castButton: SvgPicture.string(
                    SvgIcons.cast,
                    height: 100,
                    colorFilter: ColorFilter.mode(BccmPlayerTheme.safeOf(context).controls?.primaryColor ?? Colors.white, BlendMode.srcIn),
                  ),
                  aspectRatio: 16 / 9,
                ),
              ),
            ),
        []);

    return InheritedBccmPlayerViewController(
      controller: viewController,
      child: PlayerView(
        episode: episodeData,
        playlistId: playlistId,
        onReloadRequested: () async {
          episodeFuture.value = fetchEpisode();
          final r = await episodeFuture.value;
          final ep = r.parsedData?.episode;
          if (ep != null) {
            playbackService.playEpisode(
              playerId: BccmPlayerController.primary.value.playerId,
              episode: ep,
              autoplay: true,
              playlistId: playlistId,
            );
          }
        },
      ),
    );
  }
}

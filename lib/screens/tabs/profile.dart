import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bccm_core/bccm_core.dart';
import 'package:bccm_player/bccm_player.dart';
import 'package:brunstadtv_app/app_bar_with_scroll_to_top.dart';
import 'package:brunstadtv_app/components/misc/horizontal_slider.dart';
import 'package:brunstadtv_app/components/misc/parental_gate.dart';
import 'package:brunstadtv_app/components/pages/sections/section_with_header.dart';
import 'package:brunstadtv_app/components/profile/avatar.dart';
import 'package:brunstadtv_app/components/profile/empty_info.dart';
import 'package:brunstadtv_app/components/thumbnails/episode_thumbnail.dart';
import 'package:brunstadtv_app/flavors.dart';
import 'package:brunstadtv_app/providers/auth.dart';
import 'package:brunstadtv_app/providers/downloads.dart';
import 'package:brunstadtv_app/providers/feature_flags.dart';
import 'package:brunstadtv_app/providers/tabs.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:brunstadtv_app/l10n/app_localizations.dart';
import 'package:graphql/client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../components/misc/custom_grid_view.dart';
import '../../components/offline/downloaded_videos.dart';
import '../../helpers/watch_progress_bottom_sheet.dart';
import '../../components/status/error_generic.dart';
import '../../components/status/loading_generic.dart';
import '../../components/thumbnails/grid/thumbnail_grid_episode.dart';
import 'package:bccm_core/platform.dart';
import '../../helpers/svg_icons.dart';
import '../../models/episode_thumbnail_data.dart';
import '../../router/router.gr.dart';
import 'package:bccm_core/design_system.dart';

const kProfileScrollQueryLikedShorts = 'liked_shorts';
const kProfileScrollQueryDownloaded = 'downloaded';

@RoutePage()
class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({
    super.key,
    @QueryParam('scroll') this.scroll,
  });

  final String? scroll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authStateProvider.select((value) => value.user));
    final likedShortsKey = useMemoized(() => GlobalKey());
    final downloadedKey = useMemoized(() => GlobalKey());

    getMyList() {
      if (user == null) {
        return Future.value(null);
      }
      return ref.read(bccmGraphQLProvider).query$MyList(Options$Query$MyList(errorPolicy: ErrorPolicy.all));
    }

    final myListFuture = useState(useMemoized(getMyList));
    refreshFavorites() => myListFuture.value = getMyList();

    final isRouteActive = useIsRouteActive();
    useEffect(() {
      if (isRouteActive) {
        refreshFavorites();
      }
    }, [isRouteActive]);

    final design = DesignSystem.of(context);
    final downloadedVideosCount = ref.watch(downloadsProvider.select((value) => value.valueOrNull?.length ?? 0));
    final scrollController = ref.watch(tabInfosProvider.select((tabInfos) => tabInfos.profile.scrollController!));

    void scrollTo(GlobalKey key) {
      var offset = key.currentContext?.findRenderObject()?.getTransformTo(null).getTranslation().t;
      if (offset == null) {
        return;
      }
      offset = offset - MediaQuery.paddingOf(context).top - 100;
      final currentOffset = scrollController.offset;
      var targetOffset = currentOffset + offset;
      targetOffset = targetOffset.clamp(0, scrollController.position.maxScrollExtent);
      debugPrint('guide: offset: $targetOffset');
      scrollController.animateTo(targetOffset, duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
    }

    useEffect(() {
      if (scroll != null && scroll!.isNotEmpty) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (scroll == kProfileScrollQueryLikedShorts) {
            context.router.replace(ProfileScreenRoute());
            scrollTo(likedShortsKey);
          } else if (scroll == kProfileScrollQueryDownloaded) {
            context.router.replace(ProfileScreenRoute());
            scrollTo(downloadedKey);
          }
        });
      }
      return null;
    }, [scroll]);

    return Scaffold(
      appBar: AppBarWithScrollToTop(
        scrollController: scrollController,
        child: AppBar(
          title: Image(
            image: FlavorConfig.current.bccmImages!.logo,
            height: FlavorConfig.current.bccmImages!.logoHeight,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints.loose(const Size(24, 24)),
                child: CastButton(color: design.colors.tint1),
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Avatar(imageUrl: user?.picture),
                  if (user != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        user.name,
                        style: design.textStyles.headline2,
                      ),
                    )
                  else if (ref.watch(authEnabledProvider))
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: design.buttons.small(
                        onPressed: () => context.router.navigate(OnboardingScreenRoute()),
                        labelText: S.of(context).signInOrSignUp,
                      ),
                    ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: design.buttons.small(
                      variant: ButtonVariant.secondary,
                      onPressed: () async {
                        if ((FlavorConfig.current.flavor == Flavor.kids && !await checkParentalGate(context))) {
                          return;
                        }
                        if (!context.mounted) return;
                        context.router.pushNamed('/settings');
                      },
                      labelText: S.of(context).settings,
                      image: SvgPicture.string(
                        SvgIcons.settings,
                        height: 20,
                        colorFilter: ColorFilter.mode(design.colors.label1, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (user != null) ...[
            SliverToBoxAdapter(
              child: SectionWithHeader(
                title: S.of(context).yourFavorites,
                child: FutureBuilder(
                  future: myListFuture.value,
                  builder: (context, snapshot) {
                    Widget child = const SizedBox.shrink();
                    final items =
                        snapshot.data?.parsedData?.myList.entries.items.where((el) => el.item is Fragment$MyListEntry$item$$Episode).toList();
                    if (snapshot.data == null && snapshot.connectionState != ConnectionState.done) {
                      child = const SizedBox(height: 250, child: LoadingGeneric());
                    } else if (snapshot.hasError || items == null) {
                      child = SizedBox(height: 200, child: ErrorGeneric(onRetry: refreshFavorites));
                    } else if (items.isEmpty) {
                      child = Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        child: EmptyInfo(
                          icon: SvgPicture.string(
                            SvgIcons.heartFilled,
                            height: 36,
                          ),
                          title: S.of(context).saveYourFavorites,
                          details: S.of(context).saveYourFavoritesDescription,
                        ),
                      );
                    } else {
                      child = _EpisodeFavorites(items);
                    }
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: child,
                    );
                  },
                ),
              ),
            ),
            if (ref.watch(featureFlagsProvider.select((value) => value.shorts)))
              SliverToBoxAdapter(
                child: SectionWithHeader(
                  key: likedShortsKey,
                  title: S.of(context).likedShorts,
                  child: FutureBuilder(
                    future: myListFuture.value,
                    builder: (context, snapshot) {
                      Widget child = const SizedBox.shrink();
                      final items =
                          snapshot.data?.parsedData?.myList.entries.items.where((el) => el.item is Fragment$MyListEntry$item$$Short).toList();
                      if (snapshot.data == null && snapshot.connectionState != ConnectionState.done) {
                        child = const SizedBox(height: 250, child: LoadingGeneric());
                      } else if (snapshot.hasError || items == null) {
                        child = SizedBox(height: 200, child: ErrorGeneric(onRetry: refreshFavorites));
                      } else if (items.isEmpty) {
                        child = Container(
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          child: EmptyInfo(
                            icon: SvgPicture.string(
                              SvgIcons.heartFilled,
                              height: 36,
                            ),
                            title: S.of(context).saveYourFavoriteShorts,
                            details: S.of(context).saveYourFavoritesDescription,
                          ),
                        );
                      } else {
                        child = _ShortFavorites(items);
                      }
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: child,
                      );
                    },
                  ),
                ),
              ),
          ],
          if (downloadedVideosCount > 0 || ref.watch(downloadsEnabledProvider))
            SliverToBoxAdapter(
              child: DownloadedVideosSection(key: downloadedKey),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}

class _ShortFavorites extends HookConsumerWidget {
  const _ShortFavorites(this.items);

  final List<Fragment$MyListEntry> items;

  EpisodeThumbnailData getEpisodeThumbnailData(Fragment$MyListEntry$item$$Short short) {
    return EpisodeThumbnailData(
      title: '',
      duration: null,
      image: short.image,
      locked: false,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final design = DesignSystem.of(context);

    final shortItems = items.map((item) => item.item).whereType<Fragment$MyListEntry$item$$Short>();
    final bp = ResponsiveBreakpoints.of(context);
    final thumbnailWidth = bp.smallerThan(TABLET) ? 88.0 : 150.0;
    final thumbnailHeight = bp.smallerThan(TABLET) ? 120.0 : 240.0;
    const double basePadding = 16;
    return HorizontalSlider(
      height: thumbnailHeight + basePadding * 2,
      padding: const EdgeInsets.all(basePadding),
      itemCount: shortItems.length,
      itemBuilder: (context, index) {
        final item = shortItems.elementAt(index);
        return _FavoriteItemClickWrapper(
          item: item,
          analytics: SectionItemAnalyticsData(
            id: item.id,
            name: item.title,
            type: item.$__typename,
            position: index,
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(height: thumbnailHeight),
              child: Stack(
                children: [
                  EpisodeThumbnail.withSize(
                    episode: getEpisodeThumbnailData(item),
                    imageSize: Size(thumbnailWidth, thumbnailHeight),
                  ),
                  Positioned.fill(child: Container(color: design.colors.background1.withOpacity(0.3))),
                  Positioned.fill(
                    child: Center(child: SimpleShadow(offset: const Offset(0, 0), child: SvgPicture.string(SvgIcons.play, height: 24))),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EpisodeFavorites extends HookConsumerWidget {
  const _EpisodeFavorites(this.items);

  final List<Fragment$MyListEntry> items;

  EpisodeThumbnailData getEpisodeThumbnailData(Fragment$MyListEntry$item$$Episode episode) {
    return EpisodeThumbnailData(
      title: episode.title,
      duration: episode.duration,
      image: episode.image,
      locked: episode.locked,
      progress: episode.progress,
      publishDate: episode.publishDate,
    );
  }

  StreamSubscription setEpisodeProgressUpdateSubscription(ValueNotifier<List<Fragment$MyListEntry>> myListEntries) {
    return globalEventBus.on<WatchProgressUpdatedEvent>().listen((event) async {
      myListEntries.value = myListEntries.value.map(
        (entry) {
          final episodeItem = entry.item.asOrNull<Fragment$MyListEntry$item$$Episode>();
          if (episodeItem != null && episodeItem.id == event.episodeId) {
            return entry.copyWith(
              item: episodeItem.copyWith(progress: event.progress),
            );
          }
          return entry;
        },
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myListEntries = useState(items);
    useEffect(() {
      myListEntries.value = items;
      return null;
    }, [items]);

    useEffect(() {
      final subscription = setEpisodeProgressUpdateSubscription(myListEntries);
      return subscription.cancel;
    }, []);

    final episodeItems = myListEntries.value.map((item) => item.item).whereType<Fragment$MyListEntry$item$$Episode>();
    return CustomGridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: episodeItems.mapIndexed((index, item) {
        return _FavoriteItemClickWrapper(
          item: item,
          analytics: SectionItemAnalyticsData(
            id: item.id,
            name: item.title,
            type: item.$__typename,
            position: index,
          ),
          child: ThumbnailGridEpisode(
            episode: getEpisodeThumbnailData(item),
            showSecondaryTitle: false,
            aspectRatio: 16 / 9,
          ),
        );
      }).toList(),
    );
  }
}

class _FavoriteItemClickWrapper extends ConsumerWidget {
  const _FavoriteItemClickWrapper({required this.item, required this.child, required this.analytics});

  final Fragment$MyListEntry$item item;
  final SectionItemAnalyticsData analytics;
  final Widget child;

  onTap(BuildContext context, WidgetRef ref) {
    final episodeItem = item.asOrNull<Fragment$MyListEntry$item$$Episode>();
    if (episodeItem != null) {
      context.navigateTo(EpisodeScreenRoute(episodeId: episodeItem.id));
    }
    final shortItem = item.asOrNull<Fragment$MyListEntry$item$$Short>();
    if (shortItem != null) {
      context.router.push(ShortScreenRoute(id: shortItem.id));
    }
    ref.read(analyticsProvider).myListTabEntryClicked(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SectionItemAnalytics(
      data: analytics,
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(context, ref),
        onLongPress: () {
          final episodeItem = item.asOrNull<Fragment$MyListEntry$item$$Episode>();
          if (episodeItem != null) {
            showWatchProgressBottomSheet(context, ref, episodeItem.id, episodeItem.progress);
          }
        },
        child: child,
      ),
    );
  }
}

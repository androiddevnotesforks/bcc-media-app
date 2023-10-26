import 'package:brunstadtv_app/graphql/queries/page.graphql.dart';
import 'package:brunstadtv_app/helpers/extensions.dart';
import 'package:brunstadtv_app/models/analytics/sections.dart';
import 'package:brunstadtv_app/providers/analytics.dart';
import 'package:brunstadtv_app/providers/inherited_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kids/components/thumbnails/posters/playlist_poster_large.dart';
import 'package:kids/components/thumbnails/posters/poster_large.dart';
import 'package:kids/helpers/router_utils.dart';
import 'package:kids/router/router.gr.dart';
import 'package:kids/screens/show.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PosterSection extends ConsumerWidget {
  final Fragment$Section$$PosterSection data;

  const PosterSection(this.data, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bp = ResponsiveBreakpoints.of(context);
    final double sectionSpacing = bp.smallerThan(TABLET) ? 20 : 28;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: data.items.items
          .asMap()
          .entries
          .map(
            (kv) {
              final item = kv.value;
              return SizedBox(
                child: Padding(
                  padding: kv.key == data.items.items.length - 1 ? EdgeInsets.zero : EdgeInsets.only(right: sectionSpacing),
                  child: InheritedData<SectionItemAnalytics>(
                    inheritedData: SectionItemAnalytics(position: kv.key, id: item.id, type: item.item.$__typename, name: item.title),
                    child: (context) {
                      final playlistItem = item.item.asOrNull<Fragment$Section$$PosterSection$items$items$item$$Playlist>();
                      if (playlistItem != null) {
                        return PlaylistPosterLarge.fromItem(
                          item: playlistItem,
                          onPressed: () => ref.read(analyticsProvider).sectionItemClicked(context),
                        );
                      }
                      final showItem = item.item.asOrNull<Fragment$Section$$PosterSection$items$items$item$$Show>();
                      if (showItem != null) {
                        return PosterLarge(
                          image: item.image,
                          onPressed: () => ref.read(analyticsProvider).sectionItemClicked(context),
                          routeSettings: RouteSettings(
                            name: ShowScreenRoute.name,
                            arguments: ShowScreenRouteArgs(showId: showItem.id),
                          ),
                          openBuilder: (context, close) {
                            final args = ModalRoute.of(context)!.settings.arguments.asOrNull<ShowScreenRouteArgs>();
                            if (args != null) {
                              return ShowScreen(showId: args.showId);
                            }
                            return const SizedBox.shrink();
                          },
                        );
                      }
                      return PosterLarge(
                        image: item.image,
                        onPressed: () => handleSectionItemClick(context, item.item),
                      );
                    },
                  ),
                ),
              );
            },
          )
          .toList()
          .animate(interval: 50.ms)
          .slideX(begin: 1, curve: Curves.easeOutExpo, duration: 2000.ms)
          .scale(begin: const Offset(0.4, 0.4))
          .rotate(begin: 0.03)
          .fadeIn(),
    );
  }
}

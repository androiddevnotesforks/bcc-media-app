import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../helpers/btv_colors.dart';
import '../helpers/btv_typography.dart';
import '../router/router.gr.dart';
import '../graphql/queries/page.graphql.dart';
import '../graphql/schema/pages.graphql.dart';
import '../services/utils.dart';
import 'bordered_image_container.dart';
import 'horizontal_slider.dart';
import 'feature_badge.dart';
import 'episode_duration.dart';
import 'watch_progress_indicator.dart';
import 'watched_badge.dart';

const Map<Enum$SectionSize, Size> imageSize = {
  Enum$SectionSize.small: Size(140, 208),
  Enum$SectionSize.medium: Size(230, 340),
};

class PosterSection extends StatelessWidget {
  final Fragment$Section$$PosterSection data;

  const PosterSection(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (data.title != null)
          Container(
            padding: const EdgeInsets.only(
              left: 16,
              top: 19,
              right: 16,
              bottom: 5,
            ),
            child: Text(
              data.title!,
              style: BtvTextStyles.title2,
            ),
          ),
        HorizontalSlider(
          clipBehaviour: Clip.none,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          items: sectionItems,
        ),
      ],
    );
  }

  List<Widget> get sectionItems {
    final sectionItemsList = <Widget>[];
    for (var item in data.items.items) {
      if (item.item
          is Fragment$Section$$PosterSection$items$items$item$$Episode) {
        sectionItemsList
            .add(_PosterEpisodeItem(sectionItem: item, size: data.size));
      } else if (item.item
          is Fragment$Section$$PosterSection$items$items$item$$Show) {
        sectionItemsList
            .add(_PosterShowItem(sectionItem: item, size: data.size));
      }
    }
    return sectionItemsList;
  }
}

class _PosterEpisodeItem extends StatelessWidget {
  final Fragment$Section$$PosterSection$items$items sectionItem;
  final Fragment$Section$$PosterSection$items$items$item$$Episode episode;
  final Enum$SectionSize size;

  // TODO: Remove these temp variables
  bool watched = false;
  bool isLive = false;
  bool isNewItem = false;
  bool showWatchProgressIndicator = false;

  _PosterEpisodeItem({
    required this.sectionItem,
    required this.size,
  }) : episode = sectionItem.item
            as Fragment$Section$$PosterSection$items$items$item$$Episode;

  @override
  Widget build(BuildContext context) {
    final productionDate = getFormattedProductionDate(episode.productionDate);
    return GestureDetector(
      onTap: () => context.router
          .navigate(EpisodeScreenRoute(episodeId: sectionItem.id)),
      child: SizedBox(
        width: imageSize[size]!.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionItemImage,
            Container(
              margin: const EdgeInsets.only(bottom: 2),
              child: Row(
                children: [
                  if (episode.season != null)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 4),
                        child: Text(
                          episode.season!.$show.title
                              .replaceAll(' ', '\u{000A0}'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: BtvTextStyles.caption2
                              .copyWith(color: BtvColors.tint1),
                        ),
                      ),
                    ),
                  if (productionDate != null)
                    Text(
                      productionDate,
                      style: BtvTextStyles.caption2,
                    ),
                ],
              ),
            ),
            Text(
              sectionItem.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: BtvTextStyles.caption1.copyWith(color: BtvColors.label1),
            )
          ],
        ),
      ),
    );
  }

  Widget get sectionItemImage {
    final thumbnailImage = BorderedImageContainer(
      image:
          sectionItem.image != null ? NetworkImage(sectionItem.image!) : null,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      width: imageSize[size]!.width,
      height: imageSize[size]!.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          isComingSoon(episode.productionDate)
              ? Opacity(
                  opacity: 0.5,
                  child: thumbnailImage,
                )
              : thumbnailImage,
          if (isComingSoon(episode.productionDate))
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icons/Wait.png'),
                ),
              ),
            ),
          showWatchProgressIndicator
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(left: 4, bottom: 4, right: 4),
                    child: WatchProgressIndicator(
                        totalDuration: episode.duration, watchedDuration: 10),
                  ),
                )
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 12,
                    margin: const EdgeInsets.only(right: 4, bottom: 4, left: 4),
                    child: Row(
                      children: [
                        if (watched) const WatchedBadge(),
                        const Spacer(),
                        EpisodeDuration(
                            duration: getFormattedDuration(episode.duration)),
                      ],
                    ),
                  ),
                ),
          if (featuredTag != null)
            Positioned(
              top: -4,
              right: -4,
              child: featuredTag!,
            ),
        ],
      ),
    );
  }

  Widget? get featuredTag {
    if (isLive) {
      return const FeatureBadge(
        label: 'Live now',
        color: BtvColors.tint2,
      );
    } else if (isComingSoon(episode.productionDate)) {
      return const FeatureBadge(
        label: 'Coming soon',
        color: BtvColors.background2,
      );
    } else if (isNewItem) {
      return const FeatureBadge(
        label: 'New',
        color: BtvColors.tint2,
      );
    }
    return null;
  }
}

class _PosterShowItem extends StatelessWidget {
  final Fragment$Section$$PosterSection$items$items sectionItem;
  final Fragment$Section$$PosterSection$items$items$item$$Show show;
  final Enum$SectionSize size;

  bool hasNewEpisodes = false;

  _PosterShowItem({
    required this.sectionItem,
    required this.size,
  }) : show = sectionItem.item
            as Fragment$Section$$PosterSection$items$items$item$$Show;

  @override
  Widget build(BuildContext context) {
    final imageWidget = BorderedImageContainer(
      height: imageSize[size]!.height,
      margin: const EdgeInsets.only(bottom: 4),
      image:
          sectionItem.image != null ? NetworkImage(sectionItem.image!) : null,
    );

    return SizedBox(
      width: imageSize[size]!.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionItemImage,
          Text(
            sectionItem.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: BtvTextStyles.caption1.copyWith(color: BtvColors.label1),
          )
        ],
      ),
    );
  }

  Widget get sectionItemImage {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      width: imageSize[size]!.width,
      height: imageSize[size]!.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          BorderedImageContainer(
            image: sectionItem.image != null
                ? NetworkImage(sectionItem.image!)
                : null,
          ),
          if (hasNewEpisodes)
            const Positioned(
              top: -4,
              right: -4,
              child: FeatureBadge(
                label: 'New Episodes',
                color: BtvColors.tint2,
              ),
            ),
        ],
      ),
    );
  }
}

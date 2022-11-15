import 'package:auto_route/auto_route.dart';
import 'package:brunstadtv_app/components/bordered_image_container.dart';
import 'package:brunstadtv_app/helpers/btv_typography.dart';
import 'package:brunstadtv_app/helpers/utils.dart';
import 'package:flutter/material.dart';

import '../graphql/queries/page.graphql.dart';
import '../graphql/schema/pages.graphql.dart';
import '../helpers/btv_colors.dart';
import '../router/router.gr.dart';
import '../services/utils.dart';
import 'feature_badge.dart';
import 'episode_duration.dart';
import 'grid_row.dart';
import 'watch_progress_indicator.dart';
import 'watched_badge.dart';

const Map<Enum$GridSectionSize, int> _columnSize = {
  Enum$GridSectionSize.half: 2,
};

class DefaultGridSection extends StatelessWidget {
  final Fragment$Section$$DefaultGridSection data;

  const DefaultGridSection(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.title != null)
              Container(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 5,
                ),
                child: Text(
                  data.title!,
                  style: BtvTextStyles.title2,
                ),
              ),
            GridSectionList(size: data.gridSize, sectionItems: data.items.items)
          ],
        ),
      ),
    );
  }
}

class GridSectionList extends StatelessWidget {
  const GridSectionList({super.key, required this.size, required this.sectionItems});

  final Enum$GridSectionSize size;
  final List<Fragment$GridSectionItem> sectionItems;

  Widget getItemWidget(Fragment$GridSectionItem sectionItem) {
    var episode = sectionItem.item.asOrNull<Fragment$GridSectionItem$item$$Episode>();
    if (episode != null) {
      return _GridEpisodeItem(sectionItem: sectionItem, episode: episode);
    }
    var show = sectionItem.item.asOrNull<Fragment$GridSectionItem$item$$Show>();
    if (show != null) {
      return _GridShowItem(sectionItem: sectionItem, show: show);
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    final colSize = _columnSize[size] ?? _columnSize[Enum$GridSectionSize.half]!;
    final rowSize = (sectionItems.length / colSize).ceil();

    final rows = List<GridRow>.generate(rowSize, (rowIndex) {
      final firstIndex = rowIndex * colSize;
      final subList =
          firstIndex + colSize <= sectionItems.length ? sectionItems.sublist(firstIndex, firstIndex + colSize) : sectionItems.sublist(firstIndex);
      return GridRow(
        margin: const EdgeInsets.only(top: 12, bottom: 12),
        items: subList.map(getItemWidget).toList(),
        colSize: colSize,
      );
    });
    return ListView.builder(
        primary: true,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: rows.length,
        itemBuilder: (context, index) => rows[index]);
  }
}

class _GridEpisodeItem extends StatelessWidget {
  final Fragment$GridSectionItem sectionItem;
  final Fragment$GridSectionItem$item$$Episode episode;
  _GridEpisodeItem({required this.sectionItem, required this.episode});

  // TODO: Remove these temp variables
  bool get watched => episode.progress != null && episode.progress! > episode.duration * 0.9;
  bool isLive = false;
  bool isNewItem = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => handleSectionItemClick(context, sectionItem.item),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionItemImage(),
          Row(
            children: [
              if (episode.season != null)
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(right: 4),
                    child: Text(
                      episode.season!.$show.title.replaceAll(' ', '\u{000A0}'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: BtvTextStyles.caption2.copyWith(color: BtvColors.tint1),
                    ),
                  ),
                ),
              if (episode.season != null)
                Text(
                  'S${episode.season!.number}:E${episode.number}',
                  style: BtvTextStyles.caption2,
                ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 2),
            child: Text(
              sectionItem.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: BtvTextStyles.caption1.copyWith(color: BtvColors.label1),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionItemImage() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            isComingSoon(episode.availableFrom)
                ? Opacity(
                    opacity: 0.5,
                    child: BorderedImageContainer(imageUrl: sectionItem.image),
                  )
                : BorderedImageContainer(imageUrl: sectionItem.image),
            if (isComingSoon(episode.availableFrom))
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/Wait.png'),
                  ),
                ),
              ),
            episode.progress != null && !watched
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(left: 4, bottom: 4, right: 4),
                      child: WatchProgressIndicator(totalDuration: episode.duration, watchedDuration: episode.progress!),
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
                          EpisodeDuration(duration: getFormattedDuration(episode.duration)),
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
      ),
    );
  }

  Widget? get featuredTag {
    if (isLive) {
      return const FeatureBadge(
        label: 'Live now',
        color: BtvColors.tint2,
      );
    } else if (isComingSoon(episode.availableFrom)) {
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

class _GridShowItem extends StatelessWidget {
  final Fragment$GridSectionItem sectionItem;
  final Fragment$GridSectionItem$item$$Show show;
  _GridShowItem({required this.sectionItem, required this.show});

  // TODO: Remove this
  bool hasNewEpisodes = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => handleSectionItemClick(context, sectionItem.item),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionItemImage(),
          Container(
            margin: const EdgeInsets.only(bottom: 2),
            child: Text(
              sectionItem.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: BtvTextStyles.caption1.copyWith(color: BtvColors.label1),
            ),
          ),
          Text(
            '${show.seasonCount} Seasons - ${show.episodeCount} Episodes',
            style: BtvTextStyles.caption2,
          )
        ],
      ),
    );
  }

  Widget sectionItemImage() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            BorderedImageContainer(imageUrl: sectionItem.image),
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
      ),
    );
  }
}

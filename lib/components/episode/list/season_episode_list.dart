import 'package:brunstadtv_app/components/study/study_progress.dart';
import 'package:bccm_core/platform.dart';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../env/env.dart';
import '../../../helpers/episode_state.dart';
import '../../../models/breakpoints.dart';
import 'package:bccm_core/design_system.dart';
import 'package:bccm_core/bccm_core.dart';
import '../../../l10n/app_localizations.dart';
import '../../thumbnails/misc/bordered_image_container.dart';
import '../../thumbnails/misc/episode_duration.dart';

part 'season_episode_list.freezed.dart';

class SeasonEpisodeList extends StatelessWidget {
  final String? title;
  final List<SeasonEpisodeListEpisodeData> items;
  final String? selectedId;
  final void Function(int index, String id) onEpisodeTap;

  const SeasonEpisodeList({
    super.key,
    this.title,
    this.selectedId,
    required this.items,
    required this.onEpisodeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Container(
            padding: const EdgeInsets.only(top: 12, right: 16, bottom: 8, left: 16),
            margin: const EdgeInsets.only(bottom: 8),
            child: Text(
              title!,
              style: DesignSystem.of(context).textStyles.title2,
            ),
          ),
        ...items.mapIndexed(
          (index, ep) => IgnorePointer(
            ignoring: ep.episode.locked,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                onEpisodeTap(index, ep.episode.id);
              },
              child: _Episode(data: ep),
            ),
          ),
        )
      ],
    );
  }
}

@freezed
class SeasonEpisodeListEpisodeData with _$SeasonEpisodeListEpisodeData {
  const factory SeasonEpisodeListEpisodeData({
    required Fragment$SeasonListEpisode episode,
    int? seasonNumber,
    Fragment$LessonProgressOverview? lessonProgressOverview,
    bool? highlighted,
  }) = _SeasonEpisodeListEpisodeData;
}

class _Episode extends StatelessWidget {
  final SeasonEpisodeListEpisodeData data;
  const _Episode({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final publishDateTime = DateTime.tryParse(data.episode.publishDate);
    final design = DesignSystem.of(context);

    return Stack(
      children: [
        if (data.highlighted == true)
          Positioned.fill(
            child: Container(
              decoration:
                  BoxDecoration(border: Border(left: BorderSide(color: design.colors.tint2, width: 4)), color: design.colors.tint2.withOpacity(0.1)),
            ),
          ),
        Container(
          height: ResponsiveValue(
            context,
            defaultValue: 98.0,
            conditionalValues: [
              const Condition.equals(name: BP.md, value: 130.0),
              const Condition.equals(name: BP.lg, value: 160.0),
              const Condition.largerThan(name: BP.lg, value: 180.0),
            ],
          ).value,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Opacity(
                    opacity: data.episode.locked ? 0.5 : 1,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: BorderedImageContainer(imageUrl: data.episode.image),
                    ),
                  ),
                  if (data.episode.locked)
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/icons/Wait.png'),
                          ),
                        ),
                      ),
                    )
                  else
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 12,
                        margin: const EdgeInsets.only(right: 4, bottom: 4, left: 4),
                        child: Row(
                          children: [
                            const Spacer(),
                            EpisodeDuration(duration: getFormattedDuration(data.episode.duration)),
                          ],
                        ),
                      ),
                    )),
                  if (getFeatureBadge(context: context, publishDate: data.episode.publishDate, locked: data.episode.locked) != null)
                    Positioned(
                      top: -4,
                      right: -4,
                      child: getFeatureBadge(context: context, publishDate: data.episode.publishDate, locked: data.episode.locked)!,
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Opacity(
                  opacity: data.episode.locked ? 0.5 : 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            data.episode.title,
                            style: design.textStyles.caption1.copyWith(color: design.colors.label1),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (data.episode.ageRating != 'A')
                            Container(
                              margin: const EdgeInsets.only(right: 6),
                              height: 16,
                              padding: const EdgeInsets.only(right: 4, bottom: 2, left: 4),
                              decoration: BoxDecoration(
                                color: design.colors.background2,
                                border: Border.all(
                                  width: 1,
                                  color: design.colors.separatorOnLight,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Text(
                                getFormattedAgeRating(data.episode.ageRating),
                                style: design.textStyles.caption2.copyWith(color: design.colors.onTint, height: 1.1),
                              ),
                            ),
                          if (data.episode.locked &&
                              publishDateTime != null &&
                              publishDateTime.isAfter(
                                DateTime.now(),
                              ))
                            Expanded(
                              child: Text(
                                S.of(context).availableFrom(DateFormat(DateFormat.YEAR_MONTH_DAY).format(publishDateTime)),
                                overflow: TextOverflow.fade,
                                style: design.textStyles.caption2.copyWith(color: design.colors.label3),
                              ),
                            )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              if (Env.enableStudy &&
                  data.lessonProgressOverview != null &&
                  data.lessonProgressOverview!.showDiscoverPage != false &&
                  !data.episode.locked)
                Opacity(
                  opacity: data.lessonProgressOverview!.locked ? 0.2 : 1,
                  child: Container(
                    padding: const EdgeInsets.only(left: 16),
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: design.colors.separatorOnLight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: LessonProgressTree(
                          completed: data.lessonProgressOverview!.progress.completed,
                          total: data.lessonProgressOverview!.progress.total,
                          outerStrokeWidth: 2,
                          innerStrokeWidth: 1.7,
                          arcToTreePadding: 7,
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}

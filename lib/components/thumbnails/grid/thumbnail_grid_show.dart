import 'package:flutter/material.dart';

import 'package:bccm_core/platform.dart';
import '../../../l10n/app_localizations.dart';
import 'package:bccm_core/design_system.dart';

import '../show_thumbnail.dart';

class ThumbnailGridShow extends StatelessWidget {
  final Fragment$GridSectionItem sectionItem;
  final Fragment$GridSectionItem$item$$Show show;
  final double aspectRatio;
  const ThumbnailGridShow({
    super.key,
    required this.sectionItem,
    required this.show,
    required this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShowThumbnail.withWidth(
          sectionItem: sectionItem,
          imageWidth: double.infinity,
          aspectRatio: aspectRatio,
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 2),
          child: Text(
            sectionItem.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: DesignSystem.of(context).textStyles.caption1.copyWith(color: DesignSystem.of(context).colors.label1),
          ),
        ),
        Text(
          '${show.seasonCount} ${S.of(context).seasons} - ${show.episodeCount} ${S.of(context).episodes}',
          style: DesignSystem.of(context).textStyles.caption2,
        )
      ],
    );
  }
}

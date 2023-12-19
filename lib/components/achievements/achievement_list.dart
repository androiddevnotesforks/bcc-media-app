import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bccm_core/platform.dart';
import 'achievement_dialog.dart';
import 'achievement_list_item.dart';
import '../misc/custom_grid_view.dart';

class AchievementList extends ConsumerWidget {
  const AchievementList({super.key, required this.achievements});

  final List<Fragment$Achievement> achievements;
  final colSize = 3;

  Future onAchievementTapped(BuildContext context, WidgetRef ref, Fragment$Achievement item) async {
    if (!item.achieved) {
      return;
    }
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AchievementDialog(achievement: item),
    );
    final index = achievements.indexOf(item);
    ref.read(analyticsProvider).achievementClicked(AchievementClickedEvent(elementTitle: item.title, elementPosition: index));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomGridView(
      columnCount: colSize,
      horizontalSpacing: 5,
      verticalSpacing: 24,
      padding: const EdgeInsets.all(16).copyWith(bottom: 0),
      children: achievements
          .map(
            (item) => GestureDetector(
              child: AchievementListItem(item: item),
              onTap: () => onAchievementTapped(context, ref, item),
            ),
          )
          .toList(),
    );
  }
}

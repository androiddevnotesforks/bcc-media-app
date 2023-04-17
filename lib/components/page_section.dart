import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../graphql/queries/page.graphql.dart';
import '../theme/bccm_colors.dart';
import '../theme/bccm_typography.dart';

class PageSection extends StatelessWidget {
  final String? title;
  final String? description;
  final Widget child;
  final Widget? rightSlot;
  const PageSection({super.key, this.title, this.description, required this.child, this.rightSlot});
  factory PageSection.fromFragment(Fragment$Section section, {required Widget child}) {
    return PageSection(title: section.title, description: section.description, child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title?.isNotEmpty == true)
          Padding(
            padding: const EdgeInsets.only(
              left: kIsWeb ? 80 : 16,
              top: 20,
              right: 16,
              bottom: 6,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title!,
                    style: BccmTextStyles.title2,
                  ),
                ),
                if (rightSlot != null) rightSlot!
              ],
            ),
          ),
        if (description?.isNotEmpty == true)
          Padding(
            padding: const EdgeInsets.only(
              left: kIsWeb ? 80 : 16,
              right: 16,
              bottom: 8,
            ),
            child: Text(
              description!,
              style: BccmTextStyles.body2.copyWith(color: BccmColors.label3),
            ),
          ),
        child,
      ],
    );
  }
}

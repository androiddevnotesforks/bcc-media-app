import 'package:brunstadtv_app/components/category_button.dart';
import 'package:brunstadtv_app/helpers/btv_typography.dart';
import 'package:brunstadtv_app/helpers/utils.dart';
import 'package:flutter/material.dart';

import '../graphql/queries/page.graphql.dart';
import '../graphql/schema/pages.graphql.dart';
import 'grid_row.dart';

const Map<Enum$GridSectionSize, int> _columnSize = {
  Enum$GridSectionSize.half: 2,
};

class IconGridSection extends StatelessWidget {
  final Fragment$Section$$IconGridSection data;

  const IconGridSection(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.title != null)
              Container(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 16,
                ),
                child: Text(
                  data.title!,
                  style: BtvTextStyles.title2,
                ),
              ),
            _IconGridSectionList(size: data.gridSize, sectionItems: data.items.items)
          ],
        ),
      ),
    );
  }
}

class _IconGridSectionList extends StatelessWidget {
  const _IconGridSectionList({required this.size, required this.sectionItems});

  final Enum$GridSectionSize size;
  final List<Fragment$ItemSectionItem> sectionItems;

  @override
  Widget build(BuildContext context) {
    final colSize = _columnSize[size] ?? _columnSize[Enum$GridSectionSize.half]!;
    final rowSize = (sectionItems.length / colSize).ceil();

    final rows = List<GridRow>.generate(rowSize, (rowIndex) {
      final firstIndex = rowIndex * colSize;
      final subList =
          firstIndex + colSize <= sectionItems.length ? sectionItems.sublist(firstIndex, firstIndex + colSize) : sectionItems.sublist(firstIndex);
      return GridRow(
        margin: const EdgeInsets.only(bottom: 12),
        items: subList
            .map((item) => CategoryButton(
                onTap: () {
                  handleSectionItemClick(context, item.item);
                },
                label: item.title,
                networkImage: item.image,
                width: 80,
                aspectRatio: 16 / 9,
                padding: const EdgeInsets.all(8)))
            .toList(),
        colSize: colSize,
      );
    });
    return ListView.builder(
        primary: true,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: rows.length,
        itemBuilder: (context, index) => rows[index]);
  }
}
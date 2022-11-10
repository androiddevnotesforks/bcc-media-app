import 'package:brunstadtv_app/helpers/btv_typography.dart';
import 'package:brunstadtv_app/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'category_button.dart';
import 'horizontal_slider.dart';
import '../router/router.gr.dart';
import '../graphql/queries/page.graphql.dart';

class IconSection extends StatelessWidget {
  final Fragment$Section$$IconSection data;

  const IconSection(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final sectionItems = data.items.items;
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data.title != null)
            Container(
              child: Text(
                data.title!,
                style: BtvTextStyles.title2,
              ),
            ),
          HorizontalSlider(
            height: 140,
            itemCount: data.items.items.length,
            itemBuilder: (BuildContext context, int index) {
              var item = data.items.items[index];
              return CategoryButton(
                  onTap: () {
                    handleSectionItemClick(context, item.item);
                  },
                  label: item.title,
                  networkImage: item.image,
                  width: 80,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(top: 12, bottom: 4));
            },
          ),
        ],
      ),
    );
  }
}

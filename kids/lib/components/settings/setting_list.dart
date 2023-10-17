import 'dart:ui';

import 'package:brunstadtv_app/theme/design_system/design_system.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class SettingList extends StatelessWidget {
  final List<SettingListItem> items;
  final Color? backgroundColor;

  const SettingList({
    super.key,
    required this.items,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    final bp = ResponsiveBreakpoints.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Column(
        children: [
          ...items.mapIndexed(
            (index, option) => Column(
              children: [
                if (index > 0)
                  Container(
                    padding: bp.smallerThan(TABLET) ? const EdgeInsets.symmetric(horizontal: 20) : const EdgeInsets.symmetric(horizontal: 24),
                    color: design.colors.background2,
                    child: Container(width: double.infinity, height: 1, color: design.colors.separatorOnLight),
                  ),
                _ItemRenderer(
                  item: option,
                  defaultBackgroundColor: backgroundColor ?? DesignSystem.of(context).colors.background2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemRenderer extends HookWidget {
  const _ItemRenderer({
    required this.item,
    required this.defaultBackgroundColor,
  });

  final SettingListItem item;
  final Color defaultBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final hovering = useState(false);
    final animationController = useAnimationController(duration: const Duration(milliseconds: 300), initialValue: 1);
    final opacityReduction = useAnimation(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn, reverseCurve: Curves.easeIn).drive(Tween(begin: 0.3, end: 0.0)),
    );
    final design = DesignSystem.of(context);
    final bp = ResponsiveBreakpoints.of(context);
    final small = bp.smallerThan(TABLET);
    return Stack(
      children: [
        IgnorePointer(
          ignoring: item.disabled,
          child: FocusableActionDetector(
            mouseCursor: MaterialStateMouseCursor.clickable,
            onShowHoverHighlight: (value) => hovering.value = value,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (e) {
                animationController.value = 0;
              },
              onTapUp: (e) {
                item.onPressed();
                animationController.forward();
              },
              onTapCancel: () {
                animationController.value = 1;
              },
              child: Container(
                decoration: BoxDecoration(
                  color: item.disabled
                      ? defaultBackgroundColor
                      : defaultBackgroundColor.withOpacity(clampDouble(defaultBackgroundColor.opacity - opacityReduction, 0, 1)),
                ),
                child: Container(
                  padding: small ? const EdgeInsets.symmetric(horizontal: 20, vertical: 16) : const EdgeInsets.all(24),
                  constraints: const BoxConstraints(minHeight: 56),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.title,
                              style: small ? design.textStyles.title2 : design.textStyles.title1,
                            ),
                          ],
                        ),
                      ),
                      if (item.rightText != null)
                        Text(
                          item.rightText!,
                          style: (small ? design.textStyles.body2 : design.textStyles.body1).copyWith(color: design.colors.label1),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SettingListItem {
  final String title;
  final VoidCallback onPressed;
  final String? rightText;
  bool disabled;

  SettingListItem({
    required this.title,
    required this.onPressed,
    this.disabled = false,
    this.rightText,
  });
}

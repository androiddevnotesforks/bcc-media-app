import 'package:animations/animations.dart';
import 'package:brunstadtv_app/components/status/loading_indicator.dart';
import 'package:brunstadtv_app/helpers/images.dart';
import 'package:brunstadtv_app/helpers/misc.dart';
import 'package:brunstadtv_app/theme/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kids/components/buttons/button.dart';
import 'package:kids/helpers/svg_icons.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class PosterLarge extends HookWidget {
  const PosterLarge({
    super.key,
    required this.image,
    this.onPressed,
    this.openBuilder,
    this.routeSettings,
  });

  final VoidCallback? onPressed;
  final String? image;
  final OpenContainerBuilder<Object?>? openBuilder;
  final RouteSettings? routeSettings;

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    final navigationFuture = useState<Future<void>?>(null);
    final bp = ResponsiveBreakpoints.of(context);
    final isSmall = bp.smallerThan(TABLET);

    return OpenContainer(
      openBuilder: openBuilder ?? (context, close) => const SizedBox.shrink(),
      routeSettings: routeSettings,
      closedColor: const Color(0xFF051335),
      openElevation: 0,
      closedElevation: 0,
      tappable: false,
      transitionType: ContainerTransitionType.fadeThrough,
      openColor: design.colors.background1,
      openShape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(isSmall ? 20 : 40)),
      transitionDuration: const Duration(milliseconds: 500),
      closedBuilder: (
        context,
        open,
      ) =>
          AspectRatio(
        aspectRatio: 392 / 582,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                onPressed?.call();
                if (openBuilder != null) open();
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isSmall ? 20 : 40),
                child: image == null
                    ? Container(color: design.colors.separator2)
                    : Stack(
                        children: [
                          Positioned.fill(
                            child: Container(color: design.colors.separator2)
                                .animate(onComplete: (c) => c.forward(from: 0))
                                .shimmer(duration: 1000.ms)
                                .callback(delay: 1000.ms, duration: 250.ms, callback: (c) => true),
                          ),
                          SizedBox(
                            height: double.infinity,
                            child: simpleFadeInImage(url: image!),
                          ),
                        ],
                      ),
              ),
            ),
            Positioned(
              bottom: isSmall ? 16 : 40,
              right: isSmall ? 16 : 40,
              child: design.buttons.responsive(
                variant: ButtonVariant.secondary,
                onPressed: () {},
                labelText: '',
                image: SvgPicture.string(SvgIcons.play, colorFilter: ColorFilter.mode(design.colors.label1, BlendMode.srcIn)),
              ),
            ),
            if (navigationFuture.value != null)
              simpleFutureBuilder(
                  future: navigationFuture.value!,
                  loading: () => Positioned.fill(
                      child: Container(color: design.colors.background1.withOpacity(0.5), child: const Center(child: LoadingIndicator()))),
                  error: (e) => const SizedBox.shrink(),
                  noData: () => const SizedBox.shrink(),
                  ready: (d) => const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}

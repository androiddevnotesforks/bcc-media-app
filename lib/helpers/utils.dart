import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../graphql/queries/page.graphql.dart';
import '../providers/video_state.dart';
import '../router/router.gr.dart';

T? cast<T>(x) => x is T ? x : null;

extension AsExtension on Object? {
  X as<X>() => this as X;
  X? asOrNull<X>() {
    var self = this;
    return self is X ? self : null;
  }
}

ImageProvider cacheOptimizedImage(
    {required BuildContext context,
    required String imageUrl,
    required double height}) {
  return ExtendedResizeImage.resizeIfNeeded(
      provider: ExtendedNetworkImageProvider(imageUrl),
      cacheHeight: (height * MediaQuery.of(context).devicePixelRatio).round());
}

String getFormattedAgeRating(String ageRating) {
  return ageRating == 'A' ? 'A' : '$ageRating+';
}

FutureBuilder simpleFutureBuilder<T>(
    {required Future<T> future,
    required Widget Function() loading,
    required Widget Function(Object?) error,
    required Widget Function() noData,
    required Widget Function(T) ready}) {
  return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return error(snapshot.error);
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return loading();
        }
        final data = snapshot.data;
        if (data != null) {
          return ready(data);
        } else {
          return noData();
        }
      });
}

Future<dynamic>? handleSectionItemClick(
    BuildContext context, Fragment$ItemSectionItem$item item) {
  var episodeItem = item.asOrNull<Fragment$ItemSectionItem$item$$Episode>();
  if (episodeItem != null) {
    return context.router
        .navigate(EpisodeScreenRoute(episodeId: episodeItem.id));
  }

  var showItem = item.asOrNull<Fragment$ItemSectionItem$item$$Show>();
  if (showItem != null) {
    return context.router
        .navigate(EpisodeScreenRoute(episodeId: showItem.defaultEpisode.id));
  }

  var pageItem = item.asOrNull<Fragment$ItemSectionItem$item$$Page>();
  if (pageItem != null) {
    return context.router.navigate(PageScreenRoute(pageCode: pageItem.code));
  }

  var linkItem = item.asOrNull<Fragment$ItemSectionItem$item$$Link>();
  if (linkItem != null) {
    return launchUrlString(linkItem.url);
  }

  return null;
}

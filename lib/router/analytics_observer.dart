import 'package:auto_route/auto_route.dart';
import 'package:brunstadtv_app/helpers/utils.dart';
import 'package:brunstadtv_app/providers/analytics.dart';
import 'package:brunstadtv_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/constants.dart';

class AnalyticsNavigatorObserver extends NavigatorObserver {
  bool _routeFilter(Route<dynamic> route) {
    return true;
  }

  void _sendScreenView(Route<dynamic> route) {
    final context = navigator?.context;
    if (context == null) {
      return;
    }
    final ref = ProviderScope.containerOf(context);
    Map<String, Object?> extraProperties = {};
    final routeData = route.settings.asOrNull<AutoRoutePage>()?.routeData;
    if (routeData == null) return;

    var screenName = routeData.meta[RouteMetaConstants.analyticsName];
    var pageRouteArgs = routeData.args.asOrNull<PageScreenRouteArgs>();
    if (pageRouteArgs != null) {
      screenName = pageRouteArgs.pageCode;
      extraProperties['pageCode'] = pageRouteArgs.pageCode;
    }
    var episodeRouteArgs = routeData.args.asOrNull<EpisodeScreenRouteArgs>();
    if (episodeRouteArgs != null) {
      extraProperties['episodeId'] = episodeRouteArgs.episodeId;
    }

    if (screenName != null) {
      ref.read(analyticsProvider).screen(screenName, properties: extraProperties);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (_routeFilter(route)) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null && _routeFilter(newRoute)) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null && _routeFilter(previousRoute) && _routeFilter(route)) {
      _sendScreenView(previousRoute);
    }
  }
}
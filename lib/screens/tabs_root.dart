import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:brunstadtv_app/components/loading_indicator.dart';
import 'package:brunstadtv_app/components/mini_player.dart';
import 'package:brunstadtv_app/graphql/client.dart';
import 'package:brunstadtv_app/graphql/queries/devices.graphql.dart';
import 'package:brunstadtv_app/helpers/utils.dart';
import 'package:brunstadtv_app/providers/auth_state.dart';
import 'package:brunstadtv_app/providers/chromecast.dart';
import 'package:brunstadtv_app/providers/settings.dart';
import 'package:brunstadtv_app/screens/search/search.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:brunstadtv_app/providers/playback_api.dart';
import 'package:brunstadtv_app/providers/video_state.dart';
import 'package:brunstadtv_app/router/router.gr.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../components/bottom_sheet_mini_player.dart';
import '../components/custom_tab_bar.dart';

class TabsRootScreen extends ConsumerStatefulWidget {
  static const route = '/';

  const TabsRootScreen({super.key});

  @override
  ConsumerState<TabsRootScreen> createState() => _TabsRootScreenState();
}

class _TabsRootScreenState extends ConsumerState<TabsRootScreen> with AutoRouteAware {
  @override
  void initState() {
    super.initState();
    ref.read(playbackApiProvider).newPlayer().then((playerId) {
      var player = Player(playerId: playerId);
      ref.read(playbackApiProvider).setPrimary(playerId);
      ref.read(primaryPlayerProvider.notifier).setState(player);
    });
    initFcm();
  }

  StreamSubscription? fcmSubscription;
  ProviderSubscription? settingsSubscription;

  Future initFcm() async {
    var result = await FirebaseMessaging.instance.requestPermission();
    print(result.toString());
    var token = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: false, badge: false, sound: true);

    settingsSubscription = ref.listenManual<Settings>(settingsProvider, (old, value) async {
      var token = await FirebaseMessaging.instance.getToken();
      if (token != null && old?.appLanguage != value.appLanguage) {
        setDeviceToken(token);
      }
    });

    if (token != null) {
      if (!mounted) {
        return;
      }
      await setDeviceToken(token);
    }

    fcmSubscription = FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      if (!mounted) {
        return;
      }
      setDeviceToken(fcmToken);
      print('fcm token refreshed: $fcmToken');

      const storage = FlutterSecureStorage();
      storage.write(key: 'fcm_token', value: fcmToken);
      print('fcm token refreshed and stored: $fcmToken');
    });
    fcmSubscription?.onError((err) {
      print('error onTokenRefresh');
    });
  }

  Future setDeviceToken(String token) async {
    var result = await ref.read(gqlClientProvider).mutate$SetDeviceToken(Options$Mutation$SetDeviceToken(
        variables: Variables$Mutation$SetDeviceToken(token: token, languages: [ref.read(settingsProvider).appLanguage.languageCode])));
    debugPrint(result.data?.toString());
    return result;
  }

  @override
  void dispose() {
    fcmSubscription?.cancel();
    settingsSubscription?.close();
    super.dispose();
  }

  @override
  void didChangeTabRoute(TabPageRoute previousRoute) {
    print('Changed to settings tab from ${previousRoute.name}');
  }

  bool _shouldHideMiniPlayer(BuildContext context) {
    final router = context.watchRouter;
    Player? player;
    if (ref.watch(isCasting)) {
      player = ref.watch(castPlayerProvider);
    } else {
      player = ref.watch(primaryPlayerProvider);
    }
    if (player == null || player.currentMediaItem == null) {
      return true;
    }
    if (router.currentSegments.last.meta.containsKey('hide_mini_player')) {
      return true;
    }
    if (player.isInPipMode) {
      return true;
    }

    final currentEpisodePageArgs = (router.currentSegments.last.args as Object?).asOrNull<EpisodeScreenRouteArgs>();

    if (currentEpisodePageArgs?.autoplay == true) {
      return true;
    }

    final episodeId = player.currentMediaItem?.metadata?.extras?['id']?.asOrNull<String>();

    if (episodeId != null && currentEpisodePageArgs != null && currentEpisodePageArgs.episodeId == episodeId) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var routes = [
      const HomeScreenWrapperRoute(),
      SearchScreenWrapperRoute(children: [SearchScreenRoute(key: GlobalKey<SearchScreenState>())]),
    ];
    if (!ref.watch(authStateProvider).guestMode) {
      routes.addAll([
        const LiveScreenRoute(),
        const CalendarPageRoute(),
      ]);
    }
    return AutoTabsRouter(
        navigatorObservers: () => [HeroController()],
        routes: routes,
        builder: (context, child, animation) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Theme(
            data: Theme.of(context).copyWith(bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent)),
            child: Scaffold(
                body: Padding(padding: EdgeInsets.only(bottom: _shouldHideMiniPlayer(context) ? 0 : kMiniPlayerHeight), child: child),
                bottomSheet: BottomSheetMiniPlayer(hidden: _shouldHideMiniPlayer(context)),
                bottomNavigationBar: CustomTabBar(tabsRouter: tabsRouter)),
          );
        });
  }
}

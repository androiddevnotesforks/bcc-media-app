import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:brunstadtv_app/helpers/constants.dart';
import 'package:brunstadtv_app/screens/auto_login.dart';
import 'package:brunstadtv_app/screens/tabs/calendar.dart';
import 'package:brunstadtv_app/screens/settings/extra_usergroups.dart';
import 'package:brunstadtv_app/screens/games/game.dart';
import 'package:brunstadtv_app/screens/settings/about.dart';
import 'package:brunstadtv_app/screens/settings/app_language.dart';
import 'package:brunstadtv_app/screens/settings/audio_language.dart';
import 'package:brunstadtv_app/screens/settings/privacy_policy.dart';
import 'package:brunstadtv_app/screens/settings/subtitle_language.dart';
import 'package:brunstadtv_app/screens/settings/terms_of_use.dart';
import 'package:brunstadtv_app/screens/settings/video_quality.dart';
import 'package:brunstadtv_app/screens/settings/contact.dart';
import 'package:brunstadtv_app/screens/settings/faq.dart';
import 'package:brunstadtv_app/screens/tabs/home.dart';
import 'package:brunstadtv_app/screens/tabs/live.dart';
import 'package:brunstadtv_app/screens/settings/account_deletion.dart';
import 'package:brunstadtv_app/screens/onboarding/onboarding.dart';
import 'package:brunstadtv_app/screens/settings/settings.dart';
import 'package:brunstadtv_app/screens/tabs/profile.dart';
import 'package:brunstadtv_app/screens/tabs/search.dart';
import 'package:brunstadtv_app/screens/study/study.dart';
import 'package:brunstadtv_app/screens/tv/tv_live.dart';
import 'package:brunstadtv_app/screens/tv/tv_login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../screens/settings/device_info.dart';
import '../helpers/router/custom_transitions.dart';
import '../screens/study/achievement_group.dart';
import '../screens/study/achievements.dart';
import '../screens/episode.dart';
import '../screens/games/games.dart';
import '../screens/page.dart';
import '../screens/onboarding/signup.dart';
import '../screens/settings/contact_public.dart';
import '../screens/tabs/tabs_root.dart';

const _collectionEpisodeScreenRoute = CupertinoRoute<void>(
  page: CollectionEpisodeScreen,
  path: 'episode/:collectionId/:episodeId',
  meta: {RouteMetaConstants.analyticsName: 'episode'},
);

const _episodeScreenRoute = CupertinoRoute<void>(
  page: EpisodeScreen,
  path: 'episode/:episodeId',
  meta: {RouteMetaConstants.analyticsName: 'episode'},
);

const _pageScreenRoute = CupertinoRoute<void>(
  page: PageScreen,
  path: ':pageCode',
  usesPathAsKey: true,
);

Route<T> modalSheetBuilder<T>(BuildContext context, Widget child, CustomPage<T> page) {
  return ModalSheetRoute(
    settings: page,
    builder: (context) => child,
    animationCurve: Curves.easeOutCirc,
    expanded: true,
  );
}

Route<T> settingsRouteBuilder<T>(BuildContext context, Widget child, CustomPage<T> page) {
  if (!kIsWeb) return PageRouteBuilder(settings: page, pageBuilder: (context, a, b) => CustomTransitionsBuilders.slideUp(context, a, b, child));
  return DialogRoute(
    context: context,
    settings: page,
    builder: (context) => child,
  );
}

@MaterialAutoRouter(
  deferredLoading: false,
  routes: [
    AutoRoute<void>(page: AutoLoginScreen, path: '/auto-login'),
    AutoRoute<void>(page: TvLiveScreen, path: '/tv/live'),
    AutoRoute<void>(page: TvLoginScreen, path: '/tv/login'),
    CustomRoute<void>(
      page: OnboardingScreen,
      path: '/login',
      customRouteBuilder: settingsRouteBuilder,
      meta: {RouteMetaConstants.analyticsName: 'login'},
    ),
    CustomRoute<void>(
      customRouteBuilder: modalSheetBuilder,
      page: SignupScreen,
      path: 'signup',
      meta: {RouteMetaConstants.analyticsName: 'signup'},
    ),
    CustomRoute<void>(
      opaque: false,
      durationInMilliseconds: 400,
      reverseDurationInMilliseconds: 600,
      customRouteBuilder: settingsRouteBuilder,
      page: SettingsScreen,
      path: '/settings',
      meta: {RouteMetaConstants.analyticsName: 'settings'},
    ),
    CustomRoute<void>(
      page: AppLanguageScreen,
      path: '/app-language',
      durationInMilliseconds: 400,
      reverseDurationInMilliseconds: 600,
      customRouteBuilder: settingsRouteBuilder,
      meta: {RouteMetaConstants.analyticsName: 'settings', RouteMetaConstants.settingsName: 'appLanguage'},
    ),
    CustomRoute<void>(
      page: AudioLanguageScreen,
      path: '/audio-language',
      durationInMilliseconds: 400,
      reverseDurationInMilliseconds: 600,
      customRouteBuilder: settingsRouteBuilder,
      meta: {RouteMetaConstants.analyticsName: 'settings', RouteMetaConstants.settingsName: 'audioLanguage'},
    ),
    CustomRoute<void>(
      page: SubtitleLanguageScreen,
      path: '/subtitle-language',
      durationInMilliseconds: 400,
      reverseDurationInMilliseconds: 600,
      customRouteBuilder: settingsRouteBuilder,
      meta: {RouteMetaConstants.analyticsName: 'settings', RouteMetaConstants.settingsName: 'subtitlesLanguage'},
    ),
    CustomRoute<void>(
      page: VideoQualityScreen,
      path: '/video-quality',
      durationInMilliseconds: 400,
      reverseDurationInMilliseconds: 600,
      customRouteBuilder: settingsRouteBuilder,
      meta: {RouteMetaConstants.analyticsName: 'settings', RouteMetaConstants.settingsName: 'videoQuality'},
    ),
    CustomRoute<void>(
      page: ContactScreen,
      path: '/contact-support',
      durationInMilliseconds: 400,
      reverseDurationInMilliseconds: 600,
      customRouteBuilder: settingsRouteBuilder,
      meta: {RouteMetaConstants.analyticsName: 'support'},
    ),
    CustomRoute<void>(
      page: ContactPublicScreen,
      path: '/contact-support-public',
      durationInMilliseconds: 400,
      reverseDurationInMilliseconds: 600,
      customRouteBuilder: settingsRouteBuilder,
      meta: {RouteMetaConstants.analyticsName: 'support'},
    ),
    CustomRoute<void>(
      page: DeviceInfoScreen,
      path: '/device-info',
      durationInMilliseconds: 400,
      reverseDurationInMilliseconds: 600,
      customRouteBuilder: settingsRouteBuilder,
      meta: {RouteMetaConstants.analyticsName: 'support'},
    ),
    CustomRoute<void>(
      page: AboutScreen,
      path: '/about',
      durationInMilliseconds: 400,
      reverseDurationInMilliseconds: 600,
      customRouteBuilder: settingsRouteBuilder,
      meta: {RouteMetaConstants.analyticsName: 'about'},
    ),
    CustomRoute<void>(
      page: FAQScreen,
      path: '/faq',
      durationInMilliseconds: 400,
      reverseDurationInMilliseconds: 600,
      customRouteBuilder: settingsRouteBuilder,
      meta: {RouteMetaConstants.analyticsName: 'faq'},
    ),
    CustomRoute<void>(
      page: PrivacyPolicyScreen,
      path: '/privacy-policy',
      durationInMilliseconds: 400,
      reverseDurationInMilliseconds: 600,
      customRouteBuilder: settingsRouteBuilder,
      meta: {RouteMetaConstants.analyticsName: 'privacy-policy'},
    ),
    CustomRoute<void>(
      page: TermsOfUseScreen,
      path: '/terms-of-use',
      durationInMilliseconds: 400,
      reverseDurationInMilliseconds: 600,
      customRouteBuilder: settingsRouteBuilder,
      meta: {RouteMetaConstants.analyticsName: 'terms-of-use'},
    ),
    CustomRoute<void>(
      page: AccountDeletionScreen,
      path: '/account-deletion',
      durationInMilliseconds: 400,
      reverseDurationInMilliseconds: 600,
      customRouteBuilder: settingsRouteBuilder,
      meta: {RouteMetaConstants.analyticsName: 'account-deletion'},
    ),
    CupertinoRoute<void>(
      page: HomeScreen,
      name: 'PublicHomeRoute',
      path: '/public-home',
      maintainState: false,
    ),
    CustomRoute<void>(
      page: EpisodeScreen,
      name: 'EmbedScreen',
      path: '/embed/:episodeId',
      durationInMilliseconds: 300,
      reverseDurationInMilliseconds: 300,
      transitionsBuilder: CustomTransitionsBuilders.slideLeft,
      meta: {RouteMetaConstants.analyticsName: 'episode'},
    ),
    CustomRoute<void>(
      page: ExtraUsergroupsScreen,
      name: 'ExtraUsergroupsScreen',
      path: '/extra-usergroups',
      durationInMilliseconds: 400,
      reverseDurationInMilliseconds: 600,
      customRouteBuilder: settingsRouteBuilder,
      meta: {RouteMetaConstants.analyticsName: 'extra-usergroups'},
    ),
    CupertinoRoute<void>(
      page: GameScreen,
      path: '/game/:gameId',
      maintainState: false,
    ),
    CustomRoute<void>(
        page: StudyScreen,
        path: 'study-lesson',
        durationInMilliseconds: 400,
        reverseDurationInMilliseconds: 600,
        transitionsBuilder: CustomTransitionsBuilders.slideUp,
        meta: {RouteMetaConstants.analyticsName: 'study-lesson'}),
    CustomRoute<void>(
        page: AchievementsScreen,
        path: '/achievements',
        durationInMilliseconds: 400,
        reverseDurationInMilliseconds: 600,
        transitionsBuilder: CustomTransitionsBuilders.slideUp,
        meta: {RouteMetaConstants.analyticsName: 'achievements'}),
    CustomRoute<void>(
        page: AchievementGroupScreen,
        path: '/achievement-group/:groupId',
        durationInMilliseconds: 400,
        reverseDurationInMilliseconds: 600,
        transitionsBuilder: CustomTransitionsBuilders.slideUp,
        meta: {
          RouteMetaConstants.analyticsName: 'achievement-group',
        }),
    CustomRoute<void>(
      page: TabsRootScreen,
      path: '/',
      children: [
        MaterialRoute<void>(
            page: LiveScreen,
            path: 'live',
            meta: {
              RouteMetaConstants.hideMiniPlayer: true,
              RouteMetaConstants.navTabRoute: true,
              RouteMetaConstants.analyticsName: 'livestream',
            },
            maintainState: true),
        MaterialRoute<void>(
          name: 'SearchScreenWrapperRoute',
          page: EmptyRouterPage,
          path: 'search',
          children: [
            MaterialRoute<void>(
              page: SearchScreen,
              path: '',
              meta: {RouteMetaConstants.navTabRoute: true},
            ),
            _episodeScreenRoute,
            _collectionEpisodeScreenRoute,
            _pageScreenRoute,
          ],
        ),
        MaterialRoute<void>(
          page: CalendarPage,
          path: 'calendar',
          meta: {RouteMetaConstants.navTabRoute: true, RouteMetaConstants.analyticsName: 'calendar'},
        ),
        CustomRoute<void>(
          name: 'ProfileScreenWrapperRoute',
          page: EmptyRouterPage,
          path: 'profile',
          maintainState: false,
          children: [
            CustomRoute<void>(
              page: ProfileScreen,
              path: '',
              maintainState: false,
              meta: {RouteMetaConstants.navTabRoute: true},
            ),
            _episodeScreenRoute,
            _collectionEpisodeScreenRoute
          ],
        ),
        CustomRoute<void>(
          name: 'GamesWrapperRoute',
          page: EmptyRouterPage,
          path: 'games',
          maintainState: true,
          children: [
            CupertinoRoute<void>(
              page: GamesScreen,
              path: '',
              maintainState: true,
              meta: {RouteMetaConstants.navTabRoute: true},
            ),
            CupertinoRoute<void>(
              page: GameScreen,
              name: 'GamesGameScreenRoute',
              path: ':gameId',
              maintainState: false,
              meta: {RouteMetaConstants.analyticsName: 'game'},
            )
          ],
        ),
        CustomRoute<void>(name: 'HomeScreenWrapperRoute', page: EmptyRouterPage, path: '', children: [
          CupertinoRoute<void>(
            page: HomeScreen,
            path: '',
            name: 'home',
            initial: true,
            maintainState: true,
            meta: {RouteMetaConstants.navTabRoute: true},
          ),
          _episodeScreenRoute,
          _collectionEpisodeScreenRoute,
          _pageScreenRoute,
        ]),
      ],
    ),
  ],
)
class $AppRouter {}

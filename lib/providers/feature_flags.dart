import 'package:bccm_core/platform.dart';
import 'package:brunstadtv_app/env/env.dart';
import 'package:brunstadtv_app/flavors.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:unleash_proxy_client_flutter/unleash_proxy_client_flutter.dart';

import '../models/feature_flags.dart';

final featureFlagsProvider = StateNotifierProvider<FeatureFlagsNotifier, FeatureFlags>((ref) {
  return FeatureFlagsNotifier(ref.watch(rawUnleashProvider));
});

class FeatureFlagsNotifier extends StateNotifier<FeatureFlags> {
  final UnleashClient? client;
  FeatureFlagsNotifier(this.client) : super(_getFlags(client)) {
    _update();
    client?.on('update', onUnleashUpdate);
    client?.on('ready', onUnleashReady);
    client?.on('initialized', onUnleashReady);
  }

  @override
  void dispose() {
    client?.off(type: 'update', callback: onUnleashUpdate);
    client?.off(type: 'ready', callback: onUnleashReady);
    client?.off(type: 'initialized', callback: onUnleashReady);
    super.dispose();
  }

  void onUnleashUpdate(_) {
    _update();
  }

  void onUnleashReady(_) {
    _update();
  }

  _update() {
    if (!mounted) {
      debugPrint('Tried to call FeatureFlagsNotifier._update but its not mounted. This should not happen.');
      return;
    }
    state = _getFlags(client);
    debugPrint('Feature flags refreshed: $state');
  }

  static FeatureFlags _getFlags(UnleashClient? client) {
    if (client == null) return const FeatureFlags();

    return FeatureFlags(
      toggles: client.toggles,
      auth: FlavorConfig.current.flavor != Flavor.kids || client.isEnabled('kids-auth'),
      publicSignup: client.isEnabled('public-signup'),
      socialSignup: client.isEnabled('social-signup'),
      autoplayNext: FlavorConfig.current.flavor == Flavor.kids || client.isEnabled('autoplay-next'),
      shareVideoButton: FlavorConfig.current.flavor != Flavor.kids,
      flutterPlayerControls: Env.forceFlutterControls || client.isEnabled('flutter-player-controls'),
      playNextButton: client.isEnabled('play-next-button'),
      chapters: client.isEnabled('chapters'),
      chaptersFirstTab: client.isEnabled('chapters-first-tab'),
      download: client.isEnabled('download'),
      shorts: Env.forceShorts || client.isEnabled('shorts') && client.getVariant('shorts').name != 'disabled',
      shortsSourceButtonPrimary: client.isEnabled('shorts-source-button-primary'),
      shortsSharing: client.isEnabled('shorts-sharing'),
      shortsHideAutoGenerated: client.isEnabled('shorts-hide-auto-generated'),
      shortsHideBeta: client.isEnabled('shorts-hide-beta'),
      shortsGuide: client.isEnabled('shorts-guide'),
      linkToBccLive: client.isEnabled('link-to-bcc-live'),
      forceBccLive: client.isEnabled('force-bcc-live'),
      removeLiveTab: client.isEnabled('remove-live-tab'),
      disableNpawShorts: client.isEnabled('disable-npaw-shorts'),
    );
  }
}

final featureFlagVariantListProviderOverride = featureFlagVariantListProvider.overrideWith((ref) {
  return ref.watch(featureFlagsProvider.select((value) => value.toggles)).entries.fold<List<String>>([], (list, entry) {
    final variantName = entry.value.variant.name;
    if (!entry.value.enabled) return list;
    if (variantName.isEmpty || entry.value.variant.enabled == false) {
      return [...list, entry.key];
    }
    // "toggle-name:variant;"
    return [...list, '${entry.key}:$variantName'];
  });
});

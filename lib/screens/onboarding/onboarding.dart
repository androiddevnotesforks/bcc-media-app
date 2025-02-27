import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:bccm_core/platform.dart';
import 'package:brunstadtv_app/helpers/constants.dart';
import 'package:bccm_core/bccm_core.dart';
import 'package:brunstadtv_app/providers/feature_flags.dart';
import 'package:brunstadtv_app/screens/onboarding/signup.dart';

import 'package:brunstadtv_app/router/router.gr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../components/onboarding/onboarding_buttons_auth_enabled.dart';
import '../../components/web/dialog_on_web.dart';
import '../../flavors.dart';
import 'package:bccm_core/design_system.dart';
import '../../l10n/app_localizations.dart';

@RoutePage()
class OnboardingScreen extends ConsumerStatefulWidget {
  final String? loginError;
  final bool auto;

  const OnboardingScreen({
    super.key,
    this.loginError,
    @QueryParam('auto') this.auto = false,
  });

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  bool imagesLoaded = false;
  bool error = false;

  @override
  void initState() {
    super.initState();
    if (widget.auto) {
      doLogin();
    }
    Future.delayed(const Duration(milliseconds: 200)).then((_) {
      if (!mounted) return;
      setState(() => imagesLoaded = true);
    });
  }

  @override
  void didUpdateWidget(OnboardingScreen old) {
    super.didUpdateWidget(old);
    if (widget.auto && !old.auto) {
      doLogin();
    }
  }

  Future<void> doLogin() async {
    setState(() {
      error = false;
    });
    final success = await ref.read(authStateProvider.notifier).login();
    if (!mounted) return;
    if (!success) {
      setState(() {
        error = true;
      });
      return;
    }
    await tryCatchRecordErrorAsync(() {
      return ref.read(featureFlagsProvider.notifier).refresh().timeout(const Duration(seconds: 2));
    });
    ref.invalidate(appConfigFutureProvider);
    if (!mounted) return;
    context.router.replaceAll([const TabsRootScreenRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      body: Builder(
        builder: (context) => DialogOnWeb(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 44,
              shadowColor: Colors.black,
              elevation: 0,
              centerTitle: true,
              title: Image(
                image: FlavorConfig.current.bccmImages!.logo,
                height: 25,
                gaplessPlayback: true,
              ),
              automaticallyImplyLeading: false,
            ),
            body: AnimatedOpacity(
              opacity: imagesLoaded ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (kIsWeb)
                          Padding(padding: const EdgeInsets.all(16), child: Image(image: FlavorConfig.current.bccmImages!.onboarding))
                        else
                          Container(
                            height: min(220 * (MediaQuery.sizeOf(context).height / 600), MediaQuery.sizeOf(context).height - 500),
                            margin: const EdgeInsets.only(top: 40, bottom: 30),
                            child: Transform.scale(
                              scale: 1.3 * (MediaQuery.sizeOf(context).height / 800),
                              child: Image(image: FlavorConfig.current.bccmImages!.onboarding),
                            ),
                          ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 38, bottom: 12, left: 38),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  FlavorConfig.current.strings(context).onboardingTitle,
                                  style: DesignSystem.of(context).textStyles.headline2,
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Text(
                                    FlavorConfig.current.strings(context).onboardingSecondaryTitle,
                                    textAlign: TextAlign.center,
                                    style: DesignSystem.of(context).textStyles.body1.copyWith(color: DesignSystem.of(context).colors.label3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kIsWeb ? 80 : 16, vertical: max(36, MediaQuery.paddingOf(context).bottom)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (error)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(S.of(context).errorTryAgain, textAlign: TextAlign.center),
                          ),
                        OnboardingButtons(
                          loginAction: doLogin,
                          exploreAction: () {
                            context.router.popUntil((route) => false);
                            context.router.push(const TabsRootScreenRoute());
                            ref.read(sharedPreferencesProvider).setBool(PrefKeys.onboardingCompleted, true);
                          },
                          signupAction: () {
                            CupertinoScaffold.showCupertinoModalBottomSheet(
                              context: context,
                              builder: (context) => const SignupScreen(),
                              enableDrag: false,
                              duration: const Duration(milliseconds: 250),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

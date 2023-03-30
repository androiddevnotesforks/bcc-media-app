import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:brunstadtv_app/providers/feature_flags.dart';
import 'package:brunstadtv_app/screens/onboarding/signup.dart';
import 'package:brunstadtv_app/theme/bccm_typography.dart';
import 'package:brunstadtv_app/providers/auth_state/auth_state.dart';
import 'package:brunstadtv_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../helpers/ui/btv_buttons.dart';
import '../../theme/bccm_colors.dart';
import '../../helpers/widget_keys.dart';
import '../../l10n/app_localizations.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  final String? loginError;
  final void Function(bool)? onResult;
  final bool auto;

  const OnboardingScreen({
    super.key,
    this.loginError,
    this.onResult,
    @QueryParam('auto') this.auto = false,
  });

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  bool isProgressing = false;
  bool isLoggedIn = false;
  String errorMessage = '';
  bool imagesLoaded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200)).then(
      (_) => setState(() => imagesLoaded = true),
    );
    if (widget.auto) {
      loginAction();
    }
  }

  @override
  void didUpdateWidget(OnboardingScreen old) {
    super.didUpdateWidget(old);
    if (widget.auto && !old.auto) {
      loginAction();
    }
  }

  handleSuccess() {
    setState(() {
      isProgressing = false;
      isLoggedIn = true;
    });
    if (widget.onResult != null) {
      widget.onResult!(true);
    }

    context.router.replaceAll([const TabsRootScreenRoute()]);
  }

  handleError(String message) {
    setState(() {
      isProgressing = false;
      errorMessage = message;
    });
  }

  Future<void> loginAction() async {
    final tryAgainMessage = S.of(context).errorTryAgain;
    setState(() {
      isProgressing = true;
      errorMessage = '';
    });

    final success = await ref.read(authStateProvider.notifier).login();
    if (success) {
      handleSuccess();
    } else {
      handleError(tryAgainMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signupEnabled = ref.watch(featureFlagsProvider.select((value) => value.signup));
    return CupertinoScaffold(
      body: Scaffold(
        appBar: AppBar(
          toolbarHeight: 44,
          shadowColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: Image.asset('assets/images/logo.png'),
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
                    Container(
                      height: 220 * (MediaQuery.of(context).size.height / 600),
                      margin: const EdgeInsets.only(top: 40, bottom: 30),
                      child: Transform.scale(
                          scale: 1.3 * (MediaQuery.of(context).size.height / 800), child: Image.asset('assets/images/Onboarding.png')),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 38, bottom: 12, left: 38),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              S.of(context).loginPageDisplay1,
                              style: BccmTextStyles.title1,
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                S.of(context).loginPageDisplay2,
                                textAlign: TextAlign.center,
                                style: BccmTextStyles.body1.copyWith(color: BccmColors.label3),
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
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: max(36, MediaQuery.of(context).padding.bottom)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (errorMessage != '')
                      Padding(padding: const EdgeInsets.only(bottom: 16), child: Text(errorMessage, textAlign: TextAlign.center)),
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: BtvButton.large(
                        key: WidgetKeys.signInButton,
                        labelText: S.of(context).signInButton,
                        onPressed: loginAction,
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: !signupEnabled
                          ? null
                          : Builder(builder: (context) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                width: double.infinity,
                                child: BtvButton.largeSecondary(
                                  key: WidgetKeys.signUpButton,
                                  onPressed: () {
                                    CupertinoScaffold.showCupertinoModalBottomSheet(
                                      context: context,
                                      builder: (context) => const SignupScreen(),
                                      enableDrag: false,
                                      duration: const Duration(milliseconds: 250),
                                    );
                                  },
                                  labelText: S.of(context).signUpButton,
                                ),
                              );
                            }),
                    ),
                    BtvButton.mediumSecondary(
                      key: WidgetKeys.exploreButton,
                      labelText: S.of(context).explorePublicContent,
                      onPressed: () {
                        context.router.popUntil((route) => false);
                        context.router.push(const TabsRootScreenRoute());
                      },
                    ).copyWith(
                      backgroundColor: Colors.transparent,
                      border: Border.all(color: Colors.transparent),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
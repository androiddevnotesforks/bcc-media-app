import 'package:auto_route/auto_route.dart';
import 'package:bccm_core/bccm_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bccm_core/design_system.dart';

import '../../l10n/app_localizations.dart';

class ErrorNoAccess extends ConsumerWidget {
  const ErrorNoAccess({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        S.of(context).oops,
                        style: DesignSystem.of(context).textStyles.headline2,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        !ref.read(authStateProvider).isLoggedIn ? S.of(context).mustBeLoggedIn : S.of(context).dontHaveAccess,
                        textAlign: TextAlign.center,
                        style: DesignSystem.of(context).textStyles.body1.copyWith(color: DesignSystem.of(context).colors.onTint),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(S.of(context).plentyOfOtherContent,
                      textAlign: TextAlign.center,
                      style: DesignSystem.of(context).textStyles.body1.copyWith(color: DesignSystem.of(context).colors.onTint)),
                  Container(
                    padding: const EdgeInsets.only(top: 24, bottom: 28),
                    width: double.infinity,
                    child: DesignSystem.of(context).buttons.large(
                          labelText: S.of(context).exploreContent,
                          onPressed: () {
                            context.router.maybePop();
                          },
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}

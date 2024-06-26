import 'package:bccm_core/bccm_core.dart';
import 'package:bccm_core/design_system.dart';
import 'package:brunstadtv_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppUpdateDialog extends ConsumerWidget {
  const AppUpdateDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleDialog(
      title: Text(
        S.of(context).appUpdateTitle,
        style: DesignSystem.of(context).textStyles.title3,
      ),
      contentPadding: const EdgeInsets.all(24).copyWith(top: 8),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(S.of(context).appUpdateRequest),
        ),
        DesignSystem.of(context).buttons.medium(
              onPressed: () {
                openStore(
                  androidPackageName: kBccmPackageName,
                  iosStoreId: kBccmIosId,
                );
              },
              labelText: S.of(context).appUpdateAccepted,
            ),
      ],
    );
  }
}

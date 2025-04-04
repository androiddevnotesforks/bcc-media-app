import 'package:auto_route/auto_route.dart';
import 'package:brunstadtv_app/components/status/loading_generic.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/web/dialog_on_web.dart';
import 'package:bccm_core/platform.dart';
import '../../l10n/app_localizations.dart';
import 'package:bccm_core/bccm_core.dart';

import 'package:bccm_core/design_system.dart';

@RoutePage()
class AccountDeletionScreen extends HookConsumerWidget {
  const AccountDeletionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteEmailFuture = useState<Future?>(null);
    final iAmSure = useState(false);
    Future<bool> sendDeleteEmail() async {
      var sendResult = await ref.read(bccmGraphQLProvider).mutate$sendSupportEmail(
            Options$Mutation$sendSupportEmail(
              variables: Variables$Mutation$sendSupportEmail(
                title: 'Account deletion',
                content: '',
                html: '''
                    A user has requested to delete their account.<br/>
                    <strong>User ID:</strong> ${ref.read(authStateProvider).user?.id}<br/><br/>
                    Programmatically sent via the BCC Media "Delete my account" screen.<br/>
                    <strong>Important:</strong> To ensure this was really sent from this user, please request confirmation via email before proceeding with deletion.<br/>
                    ''',
              ),
            ),
          );
      if (sendResult.exception != null) {
        throw sendResult.exception!;
      }

      return sendResult.data?['sendSupportEmail'] ?? false;
    }

    return DialogOnWeb(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(S.of(context).deleteMyAccount),
        ),
        body: deleteEmailFuture.value != null
            ? simpleFutureBuilder(
                future: deleteEmailFuture.value,
                loading: () => const LoadingGeneric(text: 'Requesting deletion...'),
                ready: (v) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      S.of(context).accountDeletionSuccess(ref.read(authStateProvider).user?.email ?? ''),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            : SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).areYouSure, style: DesignSystem.of(context).textStyles.headline1),
                          const SizedBox(height: 12),
                          Text(S.of(context).accountDeletionExplanation),
                          Text(S.of(context).accountDeletionWarning),
                          const SizedBox(height: 12),
                          Text(S.of(context).accountDeletionTimeframe(7)),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Switch.adaptive(value: iAmSure.value, onChanged: (v) => iAmSure.value = v),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  S.of(context).iAmSureIWantToDelete,
                                  style: DesignSystem.of(context).textStyles.caption1,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 24),
                          DesignSystem.of(context).buttons.large(
                                variant: ButtonVariant.red,
                                disabled: !iAmSure.value,
                                onPressed: () {
                                  deleteEmailFuture.value = sendDeleteEmail();
                                },
                                labelText: S.of(context).deleteMyAccount,
                              ),
                          const SizedBox(height: 24),
                          DesignSystem.of(context).buttons.large(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                labelText: S.of(context).goBack,
                              ),
                        ],
                      ),
                    )),
              ),
      ),
    );
  }
}

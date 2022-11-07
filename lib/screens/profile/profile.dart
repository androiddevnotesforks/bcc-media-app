import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/custom_back_button.dart';
import '../../l10n/app_localizations.dart';
import '../../router/router.gr.dart';
import './avatar.dart';
import './action_buttons.dart';
import '../../components/setting_list.dart';

class Profile extends ConsumerStatefulWidget {
  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  late List<Map<String, Object?>> _settingsOptions;
  late List<Map<String, Object?>> _supportOptions;
  late List<Map<String, Object?>> _termsaAndPrivacyOptions;

  _ProfileState() {
    _settingsOptions = [
      {
        'optionName': 'Appspråk',
        'currentSelection': 'English',
        'onPressed': () {
          context.router.push(const AppLanguageScreenRoute());
        },
      },
      {
        'optionName': 'Lydspråk',
        'currentSelection': 'English',
        'onPressed': () {
          context.router.push(const AppAudioLanguageRoute());
        },
      },
      {
        'optionName': 'Språk for undertekster',
        'currentSelection': 'English',
        'onPressed': () {
          context.router.push(const AppSubtitleLanguageRoute());
        },
      },
      {
        'optionName': 'Video kvalitet',
        'currentSelection': 'Auto',
        'onPressed': () {
          context.router.push(const VideoQualityRoute());
        },
      },
    ];

    _supportOptions = [
      {
        'optionName': 'Ofte stilte spørsmål',
        'currentSelection': null,
        'onPressed': () {
          context.router.push(const FAQRoute());
        },
      },
      {
        'optionName': 'Kontakt Support',
        'currentSelection': null,
        'onPressed': () {
          context.router.push(const ContactSupportRoute());
        },
      },
      {
        'optionName': 'Om',
        'currentSelection': null,
        'onPressed': () {
          context.router.push(const AboutScreenRoute());
        },
      },
    ];

    _termsaAndPrivacyOptions = [
      {
        'optionName': 'Terms & Conditions',
        'currentSelection': null,
        'onPressed': () {},
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 92,
        leading: const CustomBackButton(),
        title: Text(S.of(context).profileTab),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Avatar(),
                ActionButtons(),
                Column(
                  children: [
                    SettingList(_settingsOptions),
                    const SizedBox(height: 24),
                    SettingList(_supportOptions),
                    const SizedBox(height: 24),
                    SettingList(_termsaAndPrivacyOptions),
                    const SizedBox(height: 24),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

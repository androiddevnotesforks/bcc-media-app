import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/nav/custom_back_button.dart';
import '../../components/menus/option_list.dart';
import '../../components/web/dialog_on_web.dart';
import '../../helpers/languages.dart';
import '../../l10n/app_localizations.dart';
import '../../models/analytics/language_changed.dart';
import '../../providers/analytics.dart';
import '../../providers/settings.dart';

@RoutePage<void>()
class AudioLanguageScreen extends ConsumerStatefulWidget {
  const AudioLanguageScreen({super.key});

  @override
  ConsumerState<AudioLanguageScreen> createState() => _AppAudioLanguageState();
}

class _AppAudioLanguageState extends ConsumerState<AudioLanguageScreen> {
  late String? selected;

  void _onSelectionChanged(String? id) {
    if (id == null) return;
    ref.read(analyticsProvider).languageChanged(LanguageChangedEvent(
          languageFrom: selected,
          languageTo: id,
          languageChangeType: 'audio',
        ));
    setState(() {
      selected = id;
    });
    ref.read(settingsProvider.notifier).setAudioLanguages([id]);
  }

  @override
  void initState() {
    super.initState();
    selected = ref.read(settingsProvider).audioLanguages.firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    return DialogOnWeb(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 44,
          leadingWidth: 92,
          leading: const CustomBackButton(),
          title: Text(S.of(context).audioLanguage),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: OptionList<String>(
                optionData: languages.entries.map((e) => Option(id: e.key, title: e.value.nativeName, subTitle: e.value.englishName)).toList(),
                currentSelection: selected,
                backgroundColor: Colors.transparent,
                onSelectionChange: _onSelectionChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

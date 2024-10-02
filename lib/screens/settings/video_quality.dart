import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../components/menus/option_list.dart';
import '../../components/web/dialog_on_web.dart';
import 'package:bccm_core/design_system.dart';
import '../../l10n/app_localizations.dart';

@RoutePage()
class VideoQualityScreen extends StatefulWidget {
  const VideoQualityScreen({super.key});

  @override
  State<VideoQualityScreen> createState() => _VideoQualityScreenState();
}

class _VideoQualityScreenState extends State<VideoQualityScreen> {
  var qualityList = [
    Option(
      id: 'Automatisk',
      title: 'Automatisk',
      subTitle: '(720p)',
    ),
    Option(
      id: 'Low',
      title: 'Low',
      subTitle: '480p',
    ),
    Option(
      id: 'Medium',
      title: 'Medium',
      subTitle: '720p',
    ),
    Option(
      id: 'High',
      title: 'High',
      subTitle: '1080p',
    ),
  ];

  String selected = 'Medium';

  void _onSelectionChanged(String? id) {
    if (id == null) return;
    setState(() {
      selected = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogOnWeb(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: DesignSystem.of(context).colors.background1,
          title: Text(S.of(context).videoQuality),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(6),
            child: Divider(
              color: DesignSystem.of(context).colors.separatorOnLight.withOpacity(0.3),
              height: 1,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: OptionList<String>(
                optionData: qualityList,
                currentSelection: selected,
                onSelectionChange: _onSelectionChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

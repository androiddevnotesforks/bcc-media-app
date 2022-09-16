import 'package:flutter/material.dart';
import '../../components/option_list.dart';
import './app_language.dart';

class AppSubtitleLanguage extends StatefulWidget {
  const AppSubtitleLanguage({super.key});

  @override
  State<AppSubtitleLanguage> createState() => _AppSubtitleLanguageState();
}

class _AppSubtitleLanguageState extends State<AppSubtitleLanguage> {
  var languageList = [
    Option(
      id: 'afr',
      title: 'Afrikaans (Afrikaans)',
    ),
    Option(
      id: 'deu',
      title: 'Deutsch (German)',
    ),
    Option(
      id: 'eng',
      title: 'English (English)',
    ),
    Option(
      id: 'dut',
      title: 'Nederlands (Dutch)',
    ),
    Option(
      id: 'tur',
      title: 'Türkçe (Turkish)',
    ),
    Option(
      id: 'est',
      title: 'Eesti (Estonian)',
    ),
    Option(
      id: 'spa',
      title: 'Español (Spanish)',
    ),
    Option(
      id: 'fra',
      title: 'Español (Spanish)',
    ),
    Option(
      id: 'ita',
      title: 'Italiano (Italian)',
    ),
    Option(
      id: 'hun',
      title: 'Magyar (Hungarian)',
    ),
    Option(
      id: 'nok',
      title: 'Norsk bokmål (Norwegian Bokmål)',
    ),
  ];

  String selected = 'Medium';

  void onSelectionChanged(String id) {
    print('onSelectionChanged');
    setState(() {
      selected = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(13, 22, 35, 1),
        title: Text('Språk for undertekster'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Divider(
            color: Color.fromRGBO(204, 221, 255, 0.3),
            height: 1,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: OptionList(
          optionData: languageList,
          currentSelection: selected,
          onSelectionChange: onSelectionChanged,
        ),
      ),
    );
  }
}
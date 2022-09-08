import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/api/sliders.dart';
import 'package:my_app/components/category_button.dart';
import 'package:my_app/sections.dart';

import '../components/search_bar.dart';
import '../services/auth_service.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  String name = AuthService.instance.parsedIdToken!.name;
  late Future<List<Section>> sectionFuture;

  @override
  void initState() {
    super.initState();
    sectionFuture = fetchSections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video app'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil('/login', (route) => false),
            child: const Text('Login page'),
          ),
        ],
      ),
      body: ListView(children: [
        const SearchBar(),
        Row(
          children: const [
            Expanded(
                child: CategoryButton(
                    label: 'Series', icon: FlutterLogo(size: 39))),
            Expanded(
                child:
                    CategoryButton(label: 'Kids', icon: FlutterLogo(size: 39))),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<Section>>(
              future: sectionFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: snapshot.data!
                          .map((s) => ItemSection.fromSection(context, s, ref))
                          .toList());
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ]),
    );
  }
}

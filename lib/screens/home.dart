import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_app/api/sliders.dart';
import 'package:my_app/components/featured.dart';
import 'package:my_app/router/router.gr.dart';
import 'package:my_app/sections.dart';

import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      appBar: null,
      body: FutureBuilder<List<Section>>(
        future: sectionFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var sections = snapshot.data!
                .map((s) => ItemSection.fromSection(context, s))
                .toList();
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                const Featured(),
                ElevatedButton(
                    onPressed: () {
                      context.router.push(ProfileRoute());
                    },
                    child: Text('Profile')),
                Column(
                  children: [...sections],
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../graphql/client.dart';
import '../../graphql/queries/search.graphql.dart';
import '../../components/search_episode_list.dart';
import '../../components/result_programs_list.dart';
import '../../helpers/btv_colors.dart';
import '../../helpers/btv_typography.dart';

class SearchResultsPage extends ConsumerStatefulWidget {
  final String searchInput;

  const SearchResultsPage(this.searchInput, {super.key})
      : assert(searchInput != '');

  @override
  ConsumerState<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends ConsumerState<SearchResultsPage> {
  late Future<Query$Search$search?> _resultFuture;

  void setResultFuture() {
    // TODO: debouncer: https://stackoverflow.com/questions/52915035/how-to-debounce-search-suggestions-in-flutters-searchpage-widget
    /// https://github.com/jifalops/debounce_throttle/blob/master/lib/debounce_throttle.dart
    final client = ref.read(gqlClientProvider);

    if (widget.searchInput != null && widget.searchInput != '') {
      _resultFuture = client
          .query$Search(
        Options$Query$Search(
          variables: Variables$Query$Search(queryString: widget.searchInput!),
        ),
      )
          .onError((error, stackTrace) {
        1;
        throw Error();
      }).then(
        (value) {
          if (value.hasException) {
            throw ErrorDescription(value.exception.toString());
          }
          return value.parsedData?.search;
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    setResultFuture();
  }

  @override
  void didUpdateWidget(SearchResultsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchInput != widget.searchInput) {
      setResultFuture();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Query$Search$search?>(
      future: _resultFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox.square(
              dimension: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasData) {
          var searchResults = snapshot.data!.result;
          if (searchResults.isEmpty) {
            return _noResultsInfoWidget;
          } else {
            final programs = searchResults
                .whereType<Fragment$SearchResultItem$$ShowSearchItem>()
                .toList();
            final episodes = searchResults
                .whereType<Fragment$SearchResultItem$$EpisodeSearchItem>()
                .toList();
            return ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                if (programs.isNotEmpty)
                  ResultProgramsList(title: 'Programs', items: programs),
                if (episodes.isNotEmpty)
                  SearchEpisodeList(title: 'Episodes', items: episodes),
              ],
            );
          }
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return const Center(
          child: SizedBox.square(
            dimension: 50,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  final _noResultsInfoWidget = Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/icons/Search_Default.png',
            width: 80, height: 80, fit: BoxFit.fill),
        Text(
          'No results found',
          textAlign: TextAlign.center,
          style: BtvTextStyles.body1.copyWith(color: BtvColors.label3),
        )
      ],
    ),
  );
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';
import 'package:my_app/services/auth_service.dart';

import '../env/.env.dart';

final gqlClientProvider = Provider<GraphQLClient>((ref) {
  final httpLink = HttpLink(
    Env.BRUNSTADTV_API_ENDPOINT,
  );

  final authLink = AuthLink(
    getToken: () async => AuthService.instance.idToken != null
        ? 'Bearer ${AuthService.instance.idToken}'
        : null,
  );

  Link link = authLink.concat(httpLink);

  final GraphQLClient client = GraphQLClient(
    /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
    cache: GraphQLCache(),
    defaultPolicies: DefaultPolicies(
        query: Policies(cacheReread: CacheRereadPolicy.ignoreAll)),
    link: link,
  );

  return client;
});
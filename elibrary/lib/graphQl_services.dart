import 'package:graphql/client.dart';

class GraphQLServices{
  String host = "";
  GraphQLServices({host}):host=host;

  GraphQLClient initGraphQLClient() {
    final Link _link = HttpLink(this.host);

    return GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );
  }

  Future query(String query, [dynamic data])async{

      final GraphQLClient _client = initGraphQLClient();

      final QueryOptions options = QueryOptions(document: gql(query), variables: data);


      final QueryResult result = await _client.query(options);
      if(result.hasException){
        throw result.exception;
      }
      return result;

  }

  Future mutate(String query, dynamic data)async{

      final GraphQLClient _client = initGraphQLClient();

      final MutationOptions options = MutationOptions(document: gql(query), variables: data);


      final QueryResult result = await _client.mutate(options);
      if(result.hasException){
        throw result.exception;
      }
      return result;

  }
}
import 'package:get/get.dart';
import 'package:elibrary/graphQl_services.dart';

class Controller extends GetxController{
  var books = [].obs;
  var authors = [].obs;
  var selectedAuhtor = 0.obs;

  GraphQLServices graphQL = GraphQLServices(host: "http://192.168.8.110:5000/graphql");

  @override
  void onInit(){
    getBooks();
    getAuthors();
    super.onInit();
  }
  updateSelectedAuthor(newValue)=>selectedAuhtor.value = newValue;
  getAuthors()async{
    try {
      const query = r'''
              query{
                authors{
                  id,
                  name,
                  books{
                  id,
                  name
                  }
                }
              }
             ''';
      final responds = await graphQL.query(query);
      authors.value = responds.data['authors'];
    }catch(e){
      print(e);
    }
  }
  getBooks()async{

    try {
      const query = r'''
              query{
                books{
                  id,
                  name,
                  author{
                  id,
                  name,
                  books{
                      id,
                      name
                    }
                  }
                }
              }
             ''';
      final responds = await graphQL.query(query);

      books.value = responds.data['books'];
    }catch(e){
      print(e);
    }
  }

  void deleteBook(int bookId)async{

    const query  = r'''
        mutation DeleteBook($id: Int!) {
          action: deleteBook(id: $id) {
            id,
            name,
             author{
              id,
              name,
              books{
                      id,
                      name
                    }
            }
          }
        }
      ''';

    final data = <String, dynamic>{
      'id': bookId,
    };

    final responds = await graphQL.mutate(query,data);
    books.value = responds.data['action'];
  }

  void updateBook(int id, String name)async{
    const query  = r'''
        mutation UpdateBook($id: Int!, $name: String!) {
          action: updateBook(id: $id, name: $name) {
            id,
            name,
             author{
              id,
              name,
              books{
                      id,
                      name
                    }
            }
          }
        }
      ''';

    final data = <String, dynamic>{
      'id': id,
      'name': name
    };

    final responds = await graphQL.mutate(query,data);
    books.value = responds.data['action'];
  }

  void addBook(String name)async{
    const query  = r'''
        mutation AddBook($authorId: Int!, $name: String!) {
          action: addBook(authorId: $authorId, name: $name) {
            id,
            name,
             author{
              id,
              name,
              books{
                      id,
                      name
                    }
            }
          }
        }
      ''';

    final data = <String, dynamic>{
      'authorId': this.selectedAuhtor.value,
      'name': name
    };

    print(this.selectedAuhtor.value);

    final responds = await graphQL.mutate(query,data);
    books.value = responds.data['action'];
  }

  void addAuthor(String name)async{
    const query  = r'''
        mutation AddAuthor($name: String!) {
          action: addAuthor(name: $name) {
            id,
            name,
             books{
              id,
              name,
              books{
                      id,
                      name
                    }
            }
          }
        }
      ''';

    final data = <String, dynamic>{
      'name': name
    };

    final responds = await graphQL.mutate(query,data);
    //print(responds);
    authors.value = responds.data['action'];
  }


}
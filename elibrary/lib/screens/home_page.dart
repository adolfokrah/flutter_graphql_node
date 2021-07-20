
import 'package:elibrary/screens/add_author.dart';
import 'package:elibrary/screens/add_new_book.dart';
import 'package:elibrary/screens/view_book.dart';
import 'package:flutter/material.dart';
import 'package:elibrary/global_veriables_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'updateBook.dart';

class HomePage extends StatelessWidget {
  final String title;
  HomePage({Key? key, required this.title}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.put(Controller());


    return Scaffold(
      appBar: AppBar(
        title: Text("Books"),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (i){
              print(i);
              switch(i){
                case 0:
                  Get.to(()=>AddNewBook());
                  break;
                case 1:
                  Get.to(()=>AddAuthor());
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return ['Add New Book','Add New Author'].asMap().entries.map((choice) {
                return PopupMenuItem(
                    value: choice.key,
                    child: Text(choice.value)
                );
              }).toList();
            },
          )
        ],
      ),
      body: Container(
        child:  Obx(()=>ListView.separated(
          separatorBuilder: (c,i){
            return Divider();
          },
          itemCount: controller.books.length,
          itemBuilder: (c,i){
            return Slidable(
              child: InkWell(
                onTap: (){
                  Get.to(()=>ViewBook(bookId: controller.books[i]['id']));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.book),
                    foregroundColor: Colors.white,
                  ),
                  title: Text("${controller.books[i]['name']}"),
                  subtitle: Text("Author: "+controller.books[i]['author']['name']),
                ),
              ),
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: [
                IconSlideAction(
                  caption: 'Update',
                  color: Colors.blue,
                  icon: Icons.edit,
                  onTap: () => Get.to(()=>EditBook(bookId: controller.books[i]['id'])),
                ),
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () => controller.deleteBook(controller.books[i]['id']),
                )
              ],
            );
          },
        )),
      )
    );
  }
}

// ListView.separated(
// separatorBuilder: (context,i){
// return Divider();
// },
// itemCount: controller.books.length,
// itemBuilder: (context, i){
// return Slidable(
// actionPane: SlidableDrawerActionPane(),
// actionExtentRatio: 0.25,
// child:  ListTile(
// leading: CircleAvatar(
// child: Icon(Icons.book),
// foregroundColor: Colors.white,
// ),
// title: Text("${controller.counter}"),
// subtitle: Text("Author: "+controller.books[i]['author']['name']),
// ),
// secondaryActions: <Widget>[
// IconSlideAction(
// caption: 'Update',
// color: Colors.blue,
// icon: Icons.edit,
// onTap: () => Get.snackbar('fe','More'),
// ),
// IconSlideAction(
// caption: 'Delete',
// color: Colors.red,
// icon: Icons.delete,
// onTap: () => controller.deleteBook(controller.books[i]['id']),
// ),
// ],
// );
// },
// )
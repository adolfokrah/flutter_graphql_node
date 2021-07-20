import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elibrary/global_veriables_controller.dart';

class ViewBook extends StatelessWidget {
  final bookId;
  const ViewBook({Key? key, required int this.bookId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.find();

    final index = controller.books.indexWhere((book) =>
    book['id'] == bookId);

    return Scaffold(
      appBar: AppBar(title: Obx(()=>Text(controller.books[index]['name'])),),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: ListView(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: Icon(Icons.book),
                      foregroundColor: Colors.white,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.books[index]['name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            Text("Auhtor: ${controller.books[index]['author']['name']}")
                          ],
                        ),
                      ),
                    ),

                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text("Other books by the author",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Divider(),
                for(var book in controller.books[index]['author']['books'])
                  if(book['id'] != bookId)
                    ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.book),
                        foregroundColor: Colors.white,
                      ),
                      title: Text("${book['name']}"),
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

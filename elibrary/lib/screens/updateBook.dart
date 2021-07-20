import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elibrary/global_veriables_controller.dart';

class EditBook extends StatelessWidget {
  final bookId;
  const EditBook({Key? key, required int this.bookId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.find();

    final _formKey = GlobalKey<FormState>();

    final index = controller.books.indexWhere((book) =>
    book['id'] == bookId);

    final bookTitleController = TextEditingController(text: controller.books[index]['name']);
    return Scaffold(
      appBar: AppBar(title: Obx(()=>Text(controller.books[index]['name'])),),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: bookTitleController,
                  decoration: InputDecoration(
                    labelText: "Book Title",
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter book title';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      controller.updateBook(bookId, bookTitleController.text);
                      Get.snackbar("Success", "Book updated");
                    }
                  },
                  child: Text("Update Book"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

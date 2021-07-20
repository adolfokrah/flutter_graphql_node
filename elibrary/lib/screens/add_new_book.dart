import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elibrary/global_veriables_controller.dart';

class AddNewBook extends StatelessWidget {
  const AddNewBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final bookTitleController = TextEditingController();
    final Controller controller = Get.find();
    final itemList = new List.from(controller.authors);
    itemList.add({
      "id":0,
      "name":"--Select Author--"
    });
    return Scaffold(
      appBar: AppBar(title: Text("Add new book"),),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Obx(()=>DropdownButtonFormField(
                    validator:(value){
                        if(value == 0){
                          return "Please select book author";
                        }
                        return null;
                    },
                    isExpanded:true,
                    value: controller.selectedAuhtor.value,
                    onChanged: (newValue) {
                     controller.updateSelectedAuthor(newValue);
                    },
                    items: itemList.map((author){
                      return DropdownMenuItem(
                        value: author['id'],
                        child: Text(author['name']),
                      );
                    }).toList(),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      controller.addBook(bookTitleController.text);
                      controller.updateSelectedAuthor(0);
                      Get.back();
                      Get.snackbar("Success", "Book added");
                    }
                  },
                  child: Text("Add New Book"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

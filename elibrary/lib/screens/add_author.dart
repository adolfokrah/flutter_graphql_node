import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elibrary/global_veriables_controller.dart';

class AddAuthor extends StatelessWidget {
  const AddAuthor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final authorNameController = TextEditingController();
    final Controller controller = Get.find();

    return Scaffold(
      appBar: AppBar(title: Text("Add Author"),),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: authorNameController,
                  decoration: InputDecoration(
                    labelText: "Author Name",
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter author name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      controller.addAuthor(authorNameController.text);
                      Get.back();
                      Get.snackbar("Success", "Author added");
                    }
                  },
                  child: Text("Add Author"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

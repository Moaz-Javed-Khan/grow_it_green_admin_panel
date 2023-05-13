import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final idController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final imageController = TextEditingController();

  final dataBaseRef = FirebaseDatabase.instance.ref('products');

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  XFile? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    setState(() {
      if (pickedImage != null) {
        _image = pickedImage;
      } else {
        print("No image picked");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: nameController,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: "Product Name",
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: descriptionController,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: "Product description",
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: priceController,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: "Product Price",
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: quantityController,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: "Product Quantity",
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 150,
                      width: 600,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Select Image",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                getImage();
                              },
                              child: Center(
                                child: _image != null
                                    ? SizedBox(
                                        width: 100,
                                        child: Image.network(
                                          _image!.path,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const Icon(Icons.image),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 300,
                height: 50,
                color: Colors.lightGreen,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_image == null) return;
                    firebase_storage.Reference ref = firebase_storage
                        .FirebaseStorage.instance
                        .ref('/pictures/${_image!.path.split('/').last}.jpeg');

                    var uploadTask = ref.putData(await _image!.readAsBytes());

                    await Future.value(uploadTask);

                    var newUrl = await ref.getDownloadURL();
                    print(newUrl);
                    String id =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    // dataBaseRef.child('4').set({
                    dataBaseRef.child(id).set({
                      'description': descriptionController.text.toString(),
                      'id': id,
                      // 'image':
                      //     "https://firebasestorage.googleapis.com/v0/b/grow-it-green.appspot.com/o/1.png?alt=media&token=f2086ffb-8dae-4cfe-8d29-8125246d724d",
                      'image': newUrl.toString(),
                      'name': nameController.text.toString(),
                      'price': priceController.text.toString(),
                      'quantity': quantityController.text.toString(),
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Product Added"),
                      ));
                      Navigator.pop(context);
                    }).onError((error, stackTrace) {
                      print(error.toString());
                    });
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

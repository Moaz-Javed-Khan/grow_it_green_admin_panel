import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddServiceView extends StatefulWidget {
  const AddServiceView({super.key});

  @override
  State<AddServiceView> createState() => _AddServiceViewState();
}

class _AddServiceViewState extends State<AddServiceView> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final initialPriceController = TextEditingController();
  final perHourRateController = TextEditingController();
  final craftsmenTypeController = TextEditingController();

  final dataBaseRef = FirebaseDatabase.instance.ref('services');

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  bool isLoading = false;

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
        title: const Text("Add Service"),
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
                        hintText: "Service Name",
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: descriptionController,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: "Service description",
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: initialPriceController,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: "Service Initial Price",
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: perHourRateController,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: "Service per Hour Rate",
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: craftsmenTypeController,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: "Service Craftsmen Type",
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
                    setState(() {
                      isLoading = true;
                    });
                    firebase_storage.Reference ref =
                        firebase_storage.FirebaseStorage.instance.ref(
                            '/serviceImages/${_image!.path.split('/').last}.jpeg');

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
                      'initialPrice': initialPriceController.text.toString(),
                      'perHourRate': perHourRateController.text.toString(),
                      'craftsmenType': craftsmenTypeController.text.toString(),
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Service Added"),
                      ));
                      Navigator.pop(context);
                      setState(() {
                        isLoading = false;
                      });
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Service Not Added"),
                      ));
                      print(error.toString());
                    });
                  },
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
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

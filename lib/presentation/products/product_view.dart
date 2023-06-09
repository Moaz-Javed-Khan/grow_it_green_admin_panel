import 'package:adminpanel/presentation/products/add_product_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final ref = FirebaseDatabase.instance.ref('products');
  final searchController = TextEditingController();
  final updatedNameController = TextEditingController();
  final updatedDescriptionController = TextEditingController();
  final updatedPriceController = TextEditingController();
  final updatedQuantityController = TextEditingController();

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddProductView();
              },
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 24.0,
                      left: 500.0,
                      bottom: 24.0,
                      right: 10.0,
                    ),
                    child: TextFormField(
                      onChanged: (String value) {
                        setState(() {});
                      },
                      controller: searchController,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        labelText: 'Search',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 500.0),
                  child: SizedBox(
                    height: 50,
                    width: 80,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Search"),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: ref.onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.data!.snapshot.value == null) {
                      return const Center(child: Text('No Product found'));
                    }
                    final list =
                        (snapshot.data!.snapshot.value as Map).values.toList();
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final title = list[index]['name'];
                        final description = list[index]['description'];
                        final price = list[index]['price'];
                        final quantity = list[index]['quantity'];
                        final image = list[index]['image'];

                        if (searchController.text.isEmpty) {
                          return ListTile(
                            leading: Image.network(image),
                            title: Text(list[index]['name']),
                            subtitle: Row(
                              children: [
                                // ignore: prefer_interpolation_to_compose_strings
                                Text('${'Price: ' + list[index]['price']} Rs.'),
                                const SizedBox(width: 20),
                                Text(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    'Quantity: ' + list[index]['quantity']),
                              ],
                            ),
                            // ignore: prefer_const_literals_to_create_immutables
                            trailing: SizedBox(
                              // height: double.infinity,
                              width: 400,
                              child: Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        showMyDialog(
                                          title,
                                          description,
                                          price,
                                          quantity,
                                          image,
                                          list[index]['id'],
                                        );
                                      },
                                      child: Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Icon(Icons.edit),
                                          const SizedBox(width: 16),
                                          const Text("Edit"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        ref
                                            .child(list[index]['id'].toString())
                                            .remove();
                                      },
                                      child: Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Icon(Icons.delete),
                                          const SizedBox(width: 16),
                                          const Text("Delete"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // const ListTile(
                                  //   leading: Icon(Icons.edit),
                                  //   title: Text("Edit"),
                                  // ),
                                  // const ListTile(
                                  //   leading: Icon(Icons.delete),
                                  //   title: Text("Delete"),
                                  // ),
                                ],
                              ),
                            ),
                          );
                        } else if (title.toLowerCase().contains(
                              searchController.text.toLowerCase().toString(),
                            )) {
                          return ListTile(
                            leading: Image.network(image),
                            title: Text(list[index]['name']),
                            subtitle: Row(
                              children: [
                                // ignore: prefer_interpolation_to_compose_strings
                                Text('${'Price: ' + list[index]['price']} Rs.'),
                                const SizedBox(width: 20),
                                Text(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    'Quantity: ' + list[index]['quantity']),
                              ],
                            ),
                            // ignore: prefer_const_literals_to_create_immutables
                            trailing: SizedBox(
                              // height: double.infinity,
                              width: 400,
                              child: Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        showMyDialog(
                                          title,
                                          description,
                                          price,
                                          quantity,
                                          image,
                                          list[index]['id'],
                                        );
                                      },
                                      child: Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Icon(Icons.edit),
                                          const SizedBox(width: 16),
                                          const Text("Edit"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        ref
                                            .child(list[index]['id'].toString())
                                            .remove();
                                      },
                                      child: Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Icon(Icons.delete),
                                          const SizedBox(width: 16),
                                          const Text("Delete"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // const ListTile(
                                  //   leading: Icon(Icons.edit),
                                  //   title: Text("Edit"),
                                  // ),
                                  // const ListTile(
                                  //   leading: Icon(Icons.delete),
                                  //   title: Text("Delete"),
                                  // ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog(
    String title,
    String description,
    String price,
    String quantity,
    String image,
    String id,
  ) async {
    updatedNameController.text = title;
    updatedDescriptionController.text = description;
    updatedPriceController.text = price;
    updatedQuantityController.text = quantity;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Update"),
          content: StatefulBuilder(builder: (context, setState) {
            return Column(
              children: [
                TextFormField(
                  controller: updatedNameController,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    hintText: "Name",
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: updatedDescriptionController,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    hintText: "Description",
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: updatedPriceController,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    hintText: "Price",
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: updatedQuantityController,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    hintText: "Quantity",
                  ),
                ),
                const SizedBox(height: 16),
                Row(
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
                        onTap: () async {
                          await getImage();
                          setState(() {});
                        },
                        child: Center(
                            child: _image != null
                                ? SizedBox(
                                    width: 100,
                                    child: Image.network(
                                      _image!.path,
                                    ),
                                  )
                                : SizedBox(
                                    width: 100,
                                    child: Image.network(
                                      image,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                            // Icon(Icons.image),
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            StatefulBuilder(builder: (context, setState) {
              return TextButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  var imageRef = FirebaseStorage.instance.ref(
                      '/productImages/${_image!.path.split('/').last}.jpeg');

                  var uploadTask =
                      imageRef.putData(await _image!.readAsBytes());

                  await Future.value(uploadTask);

                  var newUrl = await imageRef.getDownloadURL();
                  ref.child(id).update({
                    'description': updatedDescriptionController.text.toString(),
                    'image': newUrl.toString(),
                    'name': updatedNameController.text.toString(),
                    'price': updatedPriceController.text.toString(),
                    'quantity': updatedQuantityController.text.toString(),
                  }).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Product Updated"),
                    ));
                    setState(() {
                      isLoading = false;
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }).onError((error, stackTrace) {
                    setState(() {
                      isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Try again!$error"),
                    ));
                  });
                },
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Update"),
              );
            }),
          ],
        );
      },
    );
  }
}

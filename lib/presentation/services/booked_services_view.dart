import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BookedServicesView extends StatefulWidget {
  const BookedServicesView({super.key});

  @override
  State<BookedServicesView> createState() => BookedServicesViewState();
}

class BookedServicesViewState extends State<BookedServicesView> {
  final ref = FirebaseDatabase.instance.ref('bookedServices');
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      return const Center(
                        child: Text('No Booked Service found'),
                      );
                    }
                    final list =
                        (snapshot.data!.snapshot.value as Map).values.toList();
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final customerName = list[index]['customerName'];
                        // final title = list[index]['name'];
                        // final description = list[index]['description'];
                        // final price = list[index]['price'];
                        // final quantity = list[index]['quantity'];
                        // final image = list[index]['image'];

                        if (searchController.text.isEmpty) {
                          return ListTile(
                            title: Text(
                                "${list[index]['customerName']} - ${list[index]['name']}"),
                            subtitle: Row(
                              children: [
                                Text('Craftsman: ${list[index]['craftsman']}'),
                                const SizedBox(width: 20),
                                Text('Date: ${list[index]['serviceDate']}'),
                                const SizedBox(width: 20),
                                Text("Start Time: ${list[index]['startTime']}"),
                              ],
                            ),
                            trailing: SizedBox(
                              // height: double.infinity,
                              width: 400,
                              child: Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
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
                                ],
                              ),
                            ),
                          );
                        } else if (customerName.toLowerCase().contains(
                              searchController.text.toLowerCase().toString(),
                            )) {
                          return ListTile(
                            title: Text(
                                "${list[index]['customerName']} - ${list[index]['name']}"),
                            subtitle: Row(
                              children: [
                                Text('Craftsman: ${list[index]['craftsman']}'),
                                const SizedBox(width: 20),
                                Text('Date: ${list[index]['serviceDate']}'),
                                const SizedBox(width: 20),
                                Text("Start Time: ${list[index]['startTime']}"),
                              ],
                            ),
                            trailing: SizedBox(
                              // height: double.infinity,
                              width: 400,
                              child: Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
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
}

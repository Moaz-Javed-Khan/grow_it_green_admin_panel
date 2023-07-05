import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final productsRef = FirebaseDatabase.instance.ref('products');
  final servicesRef = FirebaseDatabase.instance.ref('services');
  final plantEncyclopediasRef =
      FirebaseDatabase.instance.ref('plantEncyclopedias');
  final orderedProductsRef = FirebaseDatabase.instance.ref('orderedProducts');
  final bookedServicesRef = FirebaseDatabase.instance.ref('bookedServices');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 60),
          const Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8,
                    ),
                  ),
                ),
                margin: const EdgeInsets.all(10),
                height: 125,
                width: 210,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    // ignore: prefer_const_constructors
                    Text(
                      "Number of Products",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    StreamBuilder(
                        stream: productsRef.onValue,
                        builder:
                            (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            if (snapshot.data!.snapshot.value == null) {
                              return const Center(child: Text('No Product'));
                            }
                            final list = (snapshot.data!.snapshot.value as Map)
                                .values
                                .toList();
                            return Text(
                              list.length.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8,
                    ),
                  ),
                ),
                margin: const EdgeInsets.all(10),
                height: 125,
                width: 210,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    const Text(
                      "Number of Services",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    StreamBuilder(
                        stream: servicesRef.onValue,
                        builder:
                            (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            if (snapshot.data!.snapshot.value == null) {
                              return const Center(child: Text('No Service'));
                            }
                            final list = (snapshot.data!.snapshot.value as Map)
                                .values
                                .toList();
                            return Text(
                              list.length.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8,
                    ),
                  ),
                ),
                margin: const EdgeInsets.all(10),
                height: 125,
                width: 210,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    const Text(
                      "Number of Encyclopedias",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    StreamBuilder(
                        stream: plantEncyclopediasRef.onValue,
                        builder:
                            (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            if (snapshot.data!.snapshot.value == null) {
                              return const Center(
                                  child: Text('No Encyclopedia'));
                            }
                            final list = (snapshot.data!.snapshot.value as Map)
                                .values
                                .toList();
                            return Text(
                              list.length.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8,
                    ),
                  ),
                ),
                margin: const EdgeInsets.all(10),
                height: 125,
                width: 210,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    const Text(
                      "Number of Product Orders",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    StreamBuilder(
                        stream: orderedProductsRef.onValue,
                        builder:
                            (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            if (snapshot.data!.snapshot.value == null) {
                              return const Center(
                                  child: Text('No Product Order'));
                            }
                            final list = (snapshot.data!.snapshot.value as Map)
                                .values
                                .toList();
                            return Text(
                              list.length.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8,
                    ),
                  ),
                ),
                margin: const EdgeInsets.all(10),
                height: 125,
                width: 210,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    const Text(
                      "Number of Booked Services",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    StreamBuilder(
                        stream: bookedServicesRef.onValue,
                        builder:
                            (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            if (snapshot.data!.snapshot.value == null) {
                              return const Center(
                                  child: Text('No Booked Service'));
                            }
                            final list = (snapshot.data!.snapshot.value as Map)
                                .values
                                .toList();
                            return Text(
                              list.length.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

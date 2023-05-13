import 'package:adminpanel/presentation/auth/sign_in_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PopUpMenu extends StatefulWidget {
  const PopUpMenu({super.key});

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Icon(Icons.account_box_rounded),
              const SizedBox(
                width: 10,
              ),
              const Text("My Account")
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Icon(Icons.logout),
              const SizedBox(
                width: 10,
              ),
              const Text("Logout")
            ],
          ),
        ),
      ],
      // ignore: sort_child_properties_last
      child: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text(
            "Hello, ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            user?.email != null ? user!.email! : "Unknown",
            // user!.displayName != null ? user!.displayName! : 'Unknown',
            // "Moaz Javed Khan",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(width: 12.0),
          const CircleAvatar(
            child: Icon(Icons.account_circle_outlined),
          ),
          const SizedBox(width: 12.0),
        ],
      ),
      offset: const Offset(0, 100),
      color: Colors.grey,
      elevation: 2,
      // on selected we show the dialog box
      onSelected: (value) async {
        // if value 1 show dialog
        if (value == 1) {
          print("My Account");
          // if value 2 show dialog
        } else if (value == 2) {
          await FirebaseAuth.instance.signOut();
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignInView(),
            ),
          );
        }
      },
    );
  }
}

import 'dart:developer';

import 'package:adminpanel/presentation/auth/services/signupServices.dart';
import 'package:adminpanel/presentation/auth/sign_in_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController userEmailController = TextEditingController();

  TextEditingController userPhoneController = TextEditingController();

  TextEditingController userPasswordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isObscure = true;

  emptyTextFieldSnackbar() {
    final snackBar = SnackBar(
      content: const Text('Fill Text Field Please!'),
      backgroundColor: (Colors.black),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: Colors.green,
      ),
      body: Form(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                width: 300,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Image.asset(
                      "assets/logo.png",
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: userNameController,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                          return "Enter Name correctly";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        filled: true,
                        fillColor: Colors.green.shade100,
                        labelText: 'Full name',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: userEmailController,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(
                              r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
                            ).hasMatch(value)) {
                          return "Enter Email correctly";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        filled: true,
                        fillColor: Colors.green.shade100,
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: userPhoneController,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^(?:[+0]9)?[0-9]{10,12}$')
                                .hasMatch(value)) {
                          return "Enter Phone Number correctly";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        filled: true,
                        fillColor: Colors.green.shade100,
                        labelText: 'Phone Number',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      obscureText: isObscure,
                      controller: userPasswordController,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(
                              r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
                            ).hasMatch(value)) {
                          return "Enter Password correctly";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: isObscure
                              ? const Icon(
                                  Icons.visibility,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                ),
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        filled: true,
                        fillColor: Colors.green.shade100,
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        var userName = userNameController.text.trim();
                        var userEmail = userEmailController.text.trim();
                        var userPhone = userPhoneController.text.trim();
                        var userPassword = userPasswordController.text.trim();

                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing')),
                          );

                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                email: userEmail,
                                password: userPassword,
                              )
                              .then((value) => {
                                    log("user created"),
                                    signUpUser(
                                      userName,
                                      userEmail,
                                      userPhone,
                                      userPassword,
                                    ),
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignInView(),
                                      ),
                                    ),
                                  });
                        }

                        // if (userName == "" ||
                        //     userEmail == '' ||
                        //     userPhone == '' ||
                        //     userPassword == '') {
                        //   return emptyTextFieldSnackbar();
                        // } else {
                        //   FirebaseAuth.instance
                        //       .createUserWithEmailAndPassword(
                        //         email: userEmail,
                        //         password: userPassword,
                        //       )
                        //       .then((value) => {
                        //             log("user created"),
                        //             signUpUser(
                        //               userName,
                        //               userEmail,
                        //               userPhone,
                        //               userPassword,
                        //             ),
                        //             Navigator.pushReplacement(
                        //               context,
                        //               MaterialPageRoute(
                        //                 builder: (context) => SignInView(),
                        //               ),
                        //             ),
                        //           });
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const Text("Sign up"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInView(),
                          ),
                        );
                      },
                      child: const Text("Already Have an account"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

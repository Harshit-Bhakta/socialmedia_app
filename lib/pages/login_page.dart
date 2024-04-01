import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia_app/components/button.dart';
import 'package:socialmedia_app/components/text_field.dart';
import 'dart:ui' as ui;

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void signIn() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessage(e.code);
    }
  }

  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5),
                   Column(
                     children: [
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds){
                          return ui.Gradient.linear(
                            Offset(50, 5),
                            Offset(4.0,20),
                            [
                              Color.fromARGB(255, 223, 26, 59),
                              Color.fromARGB(255, 203, 35, 127),
                            ]
                          );
                        },
                       child: Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 100,
                               )),
                     ],
                   ),
                  const SizedBox(height: 25),
                  Text("Welcome back, you've been missed!",
                      style: TextStyle(fontSize: 40, color: Colors.white)),
                  const SizedBox(height: 50),
                  MyTextField(
                    controller: emailTextController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                      controller: passwordTextController,
                      hintText: 'Password',
                      obscureText: true),
                  const SizedBox(height: 25),
                  MyButton(
                    onTap: signIn,
                    text: 'Sign in',
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(right:50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 17),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Login now',
                            style: TextStyle(
                              fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 11, 211, 221)),
                          ),
                        )
                      ],
                    ),
                  ),
                    ],
                  ),
              ),
            ),
          ),
        ),
      );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  void signUp() async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    if (passwordTextController.text != confirmpasswordController.text) {
      Navigator.pop(context);
      displayMessage("Password don't match");
      return;
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailTextController.text,
              password: passwordTextController.text);

      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email!)
          .set({
        'username': emailTextController.text.split('@')[0],
        'bio': 'Empty bio..'
      });

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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 100,
                  ),
                  const SizedBox(height: 50),
                  Text("Let's create an account for you",
                      style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 25),
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
                  const SizedBox(height: 10),
                  MyTextField(
                      controller: confirmpasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true),
                  const SizedBox(height: 25),
                  MyButton(
                    onTap: signUp,
                    text: 'Sign up',
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 123, 11, 221)),
                        ),
                      )
                    ],
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

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:[Color.fromARGB(255, 42, 218, 215), Color.fromARGB(255, 23, 225, 202)],
            stops: [0.2,0.7],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        )),
      ),
    );
  }
}

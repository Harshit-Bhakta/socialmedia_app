import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const MyTextBox({super.key, required this.text, required this.sectionName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.only(left: 15, bottom: 15),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(sectionName),
            IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.settings),
            )
          ],
        ),
        Text(text),
      ]),
    );
  }
}
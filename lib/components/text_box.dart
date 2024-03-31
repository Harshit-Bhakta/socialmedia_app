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
          gradient: LinearGradient(colors: [Color.fromARGB(255, 255, 102, 0),
           Color.fromARGB(255, 232, 0, 0), ],
           stops: [0.6,0.9],
           begin: Alignment.topCenter,
           end: Alignment.bottomCenter,
           
           )),
      padding: EdgeInsets.only(left: 15, bottom: 15),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(sectionName,
            style: TextStyle(color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold
            ),
            ),
          
            IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.settings),
              iconSize: 25,
              color: Colors.black,
            )
          ],
        ),
        Text(text,
        style: TextStyle(color: Colors.grey.shade800,
        fontWeight: FontWeight.w500,
        fontSize: 15
        ),
        ),
      ]),
    );
  }
}

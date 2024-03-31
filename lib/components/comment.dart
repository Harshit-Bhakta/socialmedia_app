import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const Comment(
      {super.key, required this.text, required this.time, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 97, 231, 255),
          borderRadius: BorderRadius.circular(4)),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text,
          style: TextStyle(color: Colors.black, fontSize: 12,fontWeight: FontWeight.w600),),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                user,
                style: TextStyle(color: Color.fromARGB(255, 129, 127, 127)),
              ),
              Text(" . ",
                  style: TextStyle(color: Color.fromARGB(255, 129, 127, 127))),
              Text(time,
                  style: TextStyle(color: Color.fromARGB(255, 129, 127, 127))),
            ],
          ),
        ],
      ),
    );
  }
}

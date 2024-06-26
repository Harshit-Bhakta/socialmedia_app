import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia_app/components/comment.dart';
import 'package:socialmedia_app/components/comment_button.dart';
import 'package:socialmedia_app/components/delete_button.dart';
import 'package:socialmedia_app/components/like_button.dart';
import 'package:socialmedia_app/helper/helper_methods.dart';

class PulsePost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final String time;
  final List<String> likes;
  const PulsePost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.time,
    required this.likes,
  });

  @override
  State<PulsePost> createState() => _PulsePostState();
}

class _PulsePostState extends State<PulsePost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  final _commentTextCOntroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('Users Posts').doc(widget.postId);

    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email]),
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now()
    });
  }

  void showCommentDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add comment'),
              content: TextField(
                controller: _commentTextCOntroller,
                decoration: InputDecoration(hintText: "Write a comment..."),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _commentTextCOntroller.clear();
                    },
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      addComment(_commentTextCOntroller.text);
                      _commentTextCOntroller.clear();
                    },
                    child: Text('Post')),
              ],
            ));
  }

  void deletePost() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('"Delete Post'),
              content: const Text("Are you sure you want to delete this post?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    final commentDocs = await FirebaseFirestore.instance
                        .collection("User Posts")
                        .doc(widget.postId)
                        .collection("Comments")
                        .get();

                    for (var doc in commentDocs.docs) {
                      await FirebaseFirestore.instance
                          .collection("User Posts")
                          .doc(widget.postId)
                          .collection("Comments")
                          .doc(doc.id)
                          .delete();
                    }
                    FirebaseFirestore.instance
                        .collection("User Posts")
                        .doc(widget.postId)
                        .delete()
                        .then((value) => print('post deleted'))
                        .catchError(
                            (error) => print("failed to delete post: $error"));

                    Navigator.pop(context);
                  },
                  child: const Text('Delete'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color.fromARGB(255, 12, 1, 126), Color.fromARGB(255, 75, 157, 230)],
          stops: [0.2,0.8],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
          ),
           borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.message,
                  style: TextStyle(color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                  ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        widget.user + '',
                        style: TextStyle(color: Color.fromARGB(255, 114, 112, 112),
                        fontSize: 19,
                        fontWeight: FontWeight.w400),
                      ),
                      Text(" . ", style: TextStyle(color: Color.fromARGB(255, 114, 112, 112),
                      fontSize: 19,
                      fontWeight: FontWeight.w400
                      )),
                      Text(widget.time,
                          style: TextStyle(color: Color.fromARGB(255, 114, 112, 112),
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          )),
                    ],
                  ),
                ],
              ),
              if (widget.user == currentUser.email)
                DeleteButton(onTap: deletePost)
            ],
          ),
          const SizedBox(width: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  LikeButton(isLiked: isLiked, onTap: toggleLike),
                  const SizedBox(height: 10),
                  Text(
                    '0',
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  CommentButton(
                    onTap: showCommentDialog,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '0',
                    style: const TextStyle(
                        color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .doc(widget.postId)
                  .collection("Comments")
                  .orderBy("CommentTime", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((doc) {
                    final commentData = doc.data() as Map<String, dynamic>;
                    return Comment(
                        text: commentData["CommentText"],
                        user: commentData["CommentedBy"],
                        time: formatDate(commentData["CommentTime"]));
                  }).toList(),
                );
              })
        ],
      ),
    );
  }
}

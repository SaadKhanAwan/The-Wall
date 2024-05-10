import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/model/comment.dart';
import 'package:the_wall/utils/spacing/space.dart';
import 'package:the_wall/view/widgets/commentbox.dart';
import 'package:the_wall/view/widgets/dailogues.dart';
import 'package:the_wall/view/widgets/likebutton.dart';
import 'package:the_wall/viewmodel/services/auth/auth_services.dart';
import 'package:the_wall/viewmodel/services/post/post_services.dart';

class PostCard extends StatefulWidget {
  final String email;
  final String post;
  final String? postId;
  final List like;

  const PostCard(
      {super.key,
      required this.email,
      required this.post,
      this.postId,
      required this.like});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool islike = false;
  final auth = AuthServices.user;
  @override
  void initState() {
    super.initState();
    islike = widget.like.contains(auth);
  }

  final TextEditingController controller = TextEditingController();

  toggleit() {
    setState(() {
      islike = !islike;
    });
  }

  String commentCount = "0";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Pixels.height(context, 0.01)),
      padding: EdgeInsets.symmetric(
          horizontal: Pixels.width(context, 0.1),
          vertical: Pixels.height(context, 0.01)),
      decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.post,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              if (FirebaseAuth.instance.currentUser != null &&
                  widget.email == FirebaseAuth.instance.currentUser!.email)
                GestureDetector(
                    onTap: () {
                      Dailogues.showDeleteBox(
                          context: context,
                          onpress: () {
                            Navigator.pop(context);

                            PostServices.deletePost(
                                    context: context, postId: widget.postId)
                                .then((value) {});
                          });
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
            ],
          ),
          Text(
            widget.email,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  LikeDislike(
                    islike: islike,
                    onTab: () async {
                      //TODO:
                      toggleit();
                      await PostServices.likeIT(
                          doc: widget.postId, islike: islike);
                    },
                  ),
                  Text(
                    widget.like.length.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.red),
                  )
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        Dailogues.showCommentBox(
                            controller: controller,
                            context: context,
                            hintText: "Enter your comment",
                            onpress: () {
                              PostServices.uploadComment(
                                      comment: controller.text,
                                      postId: widget.postId,
                                      context: context)
                                  .then((value) {
                                Navigator.pop(context);
                                controller.clear();
                              });
                            });
                      },
                      child: const Icon(Icons.message)),
                  Text(
                    commentCount,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.blue),
                  )
                ],
              ),
            ],
          ),
          StreamBuilder(
              stream: PostServices.fetchComment(
                  context: context, postId: widget.postId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                if (snapshot.hasData) {
                  var comments = snapshot.data!;
                  if (comments.isNotEmpty) {
                    commentCount = comments.length.toString();
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          Comment mycomment = comments[index];
                          return CommentBox(
                              sendername:
                                  mycomment.commentBy!.split("@")[0].toString(),
                              comment: mycomment.commentText.toString(),
                              time: mycomment.timeStamp as Timestamp);
                        });
                  } else {
                    return const Text("No comments yet.");
                  }
                } else {
                  return const Text("No data");
                }
              })
        ],
      ),
    );
  }
}

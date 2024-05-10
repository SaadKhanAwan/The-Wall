import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_wall/model/comment.dart';
import 'package:the_wall/model/post_model.dart';
import 'package:the_wall/view/widgets/dailogues.dart';

class PostServices {
  static final firestore = FirebaseFirestore.instance;
  static final firebaseAuth = FirebaseAuth.instance;
  static final postRef = firestore.collection('User_Posts');
  // create post
  static Future createPost({post}) async {
    Post mypost = Post(
        email: firebaseAuth.currentUser!.email,
        post: post,
        timeStamp: Timestamp.now(),
        likes: []);
    postRef.add(mypost.toJson());
  }

  // fetch post
  static Stream<List<Post>> fetchPost() {
    return postRef
        .orderBy("timeStamp", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        // here this is doc id doc.data()[id] in firestore
        //here this id doc (after collection id)and is giving to id in my model
        data['id'] = doc.id;
        postRef.doc(doc.id).update({"id": doc.id});
        return Post.fromJson(data);
      }).toList();
    });
  }

  //  like/ dislike
  static likeIT({islike, doc}) {
    if (islike) {
      postRef.doc(doc).update({
        "likes": FieldValue.arrayUnion([
          firebaseAuth.currentUser!.email,
        ])
      });
    } else {
      postRef.doc(doc).update({
        "likes": FieldValue.arrayRemove([
          firebaseAuth.currentUser!.email,
        ])
      });
    }
  }

  // upload  comment
  static Future uploadComment({comment, postId, required context}) async {
    try {
      Comment mycomment = Comment(
        commentBy: firebaseAuth.currentUser!.email,
        commentText: comment,
        timeStamp: Timestamp.now(),
      );
      postRef.doc(postId).collection("Comments").add(mycomment.toJson());
    } catch (e) {
      Dailogues.getSnacBar(context, e.toString());
    }
  }

  // fetch  comment
  static Stream<List<Comment>> fetchComment({postId, required context}) {
    try {
      return postRef
          .doc(postId)
          .collection("Comments")
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((docs) {
          return Comment.fromJson(docs.data());
        }).toList();
      });
    } catch (e) {
      Dailogues.getSnacBar(context, e.toString());
      return const Stream.empty();
    }
  }

  static Future deletePost({required postId, required context}) async {
    try {
      // Fetch all comments associated with the post
      final commentDocs =
          await postRef.doc(postId).collection("Comments").get();

      // Collect all futures from the deletion operations
      List<Future> deletionFutures = [];
      for (var doc in commentDocs.docs) {
        // Queue deletion of each comment
        deletionFutures.add(
            postRef.doc(postId).collection("Comments").doc(doc.id).delete());
      }

      // Await all deletions to finish
      await Future.wait(deletionFutures);

      // Once all comments are deleted, delete the post
      await postRef.doc(postId).delete();
    } catch (e) {
      Dailogues.getSnacBar(context, e.toString());
    }
  }
}

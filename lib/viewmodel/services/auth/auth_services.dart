import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/model/users.dart';

import 'package:the_wall/view/widgets/dailogues.dart';

class AuthServices {
  static final auth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;
  static final postRef = firestore.collection('Users');
  static final user = auth.currentUser;

  // creating user
  static Future<User?> signUp(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? newUser = userCredential.user;
      if (newUser != null) {
        await firestore.collection('Users').doc(newUser.email).set({
          'username': newUser.email!.split('@')[0],
          'bio': 'Feeling Happy',
          'email': newUser.email
        });
        return newUser;
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

// login user
  static Future signIn({
    email,
    password,
    context,
  }) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      Dailogues.getSnacBar(context, e.toString());
    }
  }

// sign out user
  static Future signOut({
    required BuildContext context,
  }) async {
    try {
      await auth.signOut();
      // ignore: use_build_context_synchronously
      Dailogues.getSnacBar(context, "logout succussfully ");
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      // ignore: use_build_context_synchronously
      Dailogues.getSnacBar(context, e.toString());
    }
  }

// fetch user

  static Stream fetchUser() {
    return postRef.doc(user!.email).snapshots().map((snapshot) {
      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        return Users.fromJson(data);
      } else {
        throw Exception('User not found');
      }
    });
  }

  // update user
  static updateUser(context, field, updatefield) async {
    try {
      await postRef.doc(user!.email).update({
        field: updatefield,
      });
      log("update");
    } catch (e) {
      Dailogues.getSnacBar(context, "$e");
      log(e.toString());
    }
  }
}

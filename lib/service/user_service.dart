import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/infra/firebase_erros.dart';
import 'package:loja_virtual/model/ordem_item.dart';
import 'package:loja_virtual/model/user.dart' as users;

class UserService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? userFirebase;
  users.User? user;
  String? iduser;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$iduser');

  CollectionReference get cartReference => firestoreRef.collection('cart');

  CollectionReference get tokensReference => firestoreRef.collection('tokens');

  Future<User?> signIn(
      {required users.User user, Function? onFail, Function? onSuccess}) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      userFirebase = result.user;
      user.id = result.user?.uid;
      iduser = user.id;
      if (onSuccess != null) {
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      if (onFail != null) {
        onFail(getErrorString(e.code));
      }
    }
    return userFirebase;
  }

  Future<void> signUp(
      {required users.User user, Function? onFail, Function? onSuccess}) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      userFirebase = result.user;
      user.id = result.user?.uid;
      iduser = user.id;
      await firestoreRef.set(user.toJson);

      if (onSuccess != null) {
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      if (onFail != null) {
        onFail(getErrorString(e.code));
      }
    }
  }

  Future<DocumentSnapshot?> getUser(String uui) async {
    var doc = FirebaseFirestore.instance.collection('users').doc(uui).get();
    return doc;
  }

  Future<QuerySnapshot> getUsers() async {
    final docs = FirebaseFirestore.instance.collection('users').get();
    return docs;
  }

  Future<User?> loadCurrentUser() async {
    return auth.currentUser;
  }

  Future<void> saveToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint("token1 ${token!}");

    await tokensReference.doc(token).set({
      'token': token,
      'updatedAt': FieldValue.serverTimestamp(),
      'platform': Platform.operatingSystem,
    });
  }

  void signOut() {
    auth.signOut();
  }

  void updateCartProduct(OrderItem item) {
    cartReference.doc(item.id).update(item.toMap());
  }

  void removeCart(OrderItem item) {
    cartReference.doc(item.id).delete();
  }
}

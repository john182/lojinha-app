import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:loja_virtual/model/product.dart';

class ProductService {
  final _firestore = FirebaseFirestore.instance;

  final _storage = FirebaseStorage.instance;

  String? id;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('products/$id');

  Reference get storageRef => _storage.ref().child('products').child(id!);

  Future<List<Product>> loadAllProducts() async {
    final QuerySnapshot snapProducts =
        await _firestore.collection('products').get();

    final products =
        snapProducts.docs.map((d) => Product.fromDocument(d)).toList();

    return products;
  }

  Future<DocumentSnapshot?> getProduct(String uid) async {
    id = uid;
    var doc = firestoreRef.get();
    return doc;
  }

  Future<DocumentReference> add(Map<String, dynamic> data) async {
    return _firestore.collection('products').add(data);
  }

  Future<void> update(Map<String, dynamic> data) async {
    firestoreRef.update(data);
  }

  Future<void> updateImages(List<String> images) async {
    firestoreRef.update({'images': images});
  }

  Future<TaskSnapshot> upload(dynamic file) async {
    final task = storageRef.putFile(file as File);
    return task;
  }

  Future<void> removerFile(String url) async {
    _storage.ref(url).delete();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/model/product.dart';

class ProductService {
  final _firestore = FirebaseFirestore.instance;
  String? id;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('products/$id');

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
}

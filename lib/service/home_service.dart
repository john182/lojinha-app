import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  final _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> loadAll() async {
    return _firestore.collection('home').get();
  }
}

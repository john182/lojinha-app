import 'package:cloud_firestore/cloud_firestore.dart';

class AddressService {
  final _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getCoordinates() {
    final doc = _firestore.doc('aux/delivery').get();
    return doc;
  }
}

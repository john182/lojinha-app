import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/model/ordem_item.dart';
import 'package:loja_virtual/model/product.dart';
import 'package:loja_virtual/model/user.dart';

class OrderService {
  final _firestore = FirebaseFirestore.instance;

  Future<int> getOrderId() async {
    final ref = _firestore.doc('aux/ordercounter');

    try {
      final result = await _firestore.runTransaction((tx) async {
        final doc = await tx.get(ref);
        final orderId = doc.get('current') as int;
        tx.update(ref, {'current': orderId + 1});
        return {'orderId': orderId};
      });
      return (result['orderId'] ?? "0") as int;
    } catch (e) {
      return Future.error('Falha ao gerar número do pedido');
    }
  }

  Future<void> decrementStock(List<OrderItem> items) {
    // 1. Ler todos os estoques 3xM
    // 2. Decremento localmente os estoques 2xM
    // 3. Salvar os estoques no firebase 2xM

    return _firestore.runTransaction((tx) async {
      final List<Product> productsToUpdate = [];
      final List<Product> productsWithoutStock = [];

      for (final cartProduct in items) {
        Product product;

        if (productsToUpdate.any((p) => p.id == cartProduct.productId)) {
          product =
              productsToUpdate.firstWhere((p) => p.id == cartProduct.productId);
        } else {
          final doc =
          await tx.get(_firestore.doc('products/${cartProduct.productId}'));
          product = Product.fromDocument(doc);
        }

        cartProduct.product = product;

        final size = product.findSize(cartProduct.size);
        if (size!.stock - cartProduct.quantity < 0) {
          productsWithoutStock.add(product);
        } else {
          size.stock -= cartProduct.quantity;
          productsToUpdate.add(product);
        }
      }

      if (productsWithoutStock.isNotEmpty) {
        return Future.error(
            '${productsWithoutStock.length} produtos sem estoque');
      }

      for (final product in productsToUpdate) {
        tx.update(_firestore.doc('products/${product.id}'),
            {'sizes': product.exportSizeList()});
      }
    });
  }

  Future<void> save(String id, Map<String, dynamic> map) async {
    _firestore.collection('orders').doc(id).set(map);
  }

  Stream<QuerySnapshot> listenToOrders(User user) {
    final snapshots = _firestore
        .collection('orders')
        .where('userId', isEqualTo: user.id)
        .snapshots();

    return snapshots;
  }
}

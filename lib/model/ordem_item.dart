import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/model/product.dart';

import 'item_size.dart';

class OrderItem {
  String? id;
  String productId;
  int quantity;
  String size;

  Product? product;

  OrderItem(
      {this.id,
      required this.productId,
      required this.quantity,
      required this.size,
      this.product});

  factory OrderItem.fromProduct(Product prod, String size) {
    return OrderItem(
      productId: prod.id!,
      quantity: 1,
      size: size,
      product: prod,
    );
  }

  factory OrderItem.fromDocument(DocumentSnapshot document) {
    return OrderItem(
      id: document.id,
      productId: document.get('pid') as String,
      quantity: document.get('quantity') as int,
      size: document.get('size') as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
    };
  }

  ItemSize? get itemSize {
    if (product == null) return null;
    return product!.findSize(size);
  }

  num get unitPrice {
    if (product == null) return 0;
    return itemSize?.price ?? 0;
  }

  num get totalPrice => unitPrice * quantity;

  bool get hasStock {
    final size = itemSize;
    if (size == null) return false;
    return size.stock >= quantity;
  }
}

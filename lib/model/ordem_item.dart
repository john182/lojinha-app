import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/model/product.dart';

import 'item_size.dart';

class OrderItem {
  String? id;
  String productId;
  int quantity;
  String size;
  num? fixedPrice;
  Product? product;

  OrderItem(
      {this.id,
      required this.productId,
      required this.quantity,
      required this.size,
      this.fixedPrice,
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

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id'] as String?,
      productId: map['productId'] as String,
      quantity: map['quantity'] as int,
      size: map['size'] as String,
      fixedPrice: 0,
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
      'size': size,
      'fixedPrice': fixedPrice,
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
    if (product != null && product!.deleted) return false;

    final size = itemSize;
    if (size == null) return false;
    return size.stock >= quantity;
  }
}

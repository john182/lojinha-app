import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/model/ordem_item.dart';

import 'address.dart';

enum Status { canceled, pending, preparing, transporting, delivered }

class Order {
  String? orderId;
  String? userId;
  List<OrderItem> items;
  num price;
  Address? address;
  DateTime? date;
  Status status;

  Order({
    this.orderId,
    this.userId,
    required this.items,
    this.price = 0.0,
    this.address,
    this.date,
    this.status = Status.pending,
  });

  factory Order.init() {
    return Order(
      items: [],
    );
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['orderId'] as String?,
      userId: map['userId'] as String,
      items: (map['items'] as List<dynamic>)
          .map((e) => OrderItem.fromMap(e as Map<String, dynamic>))
          .toList(),
      price: map['price'] as num,
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
      status: Status.values[map['status'] as int],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items.map((e) => e.toMap()).toList(),
      'price': price,
      'status': status.index,
      'address': address?.toMap(),
      'date': Timestamp.now()
    };
  }

  String get formattedId => '#${orderId?.padLeft(6, '0')}';
}

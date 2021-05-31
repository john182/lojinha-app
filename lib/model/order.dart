import 'package:loja_virtual/model/ordem_item.dart';

import 'address.dart';

class Order {
  String? orderId;
  String? userId;
  List<OrderItem> items;
  num price;
  Address? address;
  DateTime? date;

  Order({
    this.orderId,
    this.userId,
    this.items = const [],
    this.price = 0.0,
    this.address,
    this.date,
  });

  factory Order.init() {
    return Order(
      items: [],
    );
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['orderId'] as String,
      userId: map['userId'] as String,
      items: map['items'] as List<OrderItem>,
      price: map['price'] as num,
      address: map['address'] as Address,
      date: map['date'] as DateTime,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'items': items.map((e) => e.toMap()).toList(),
      'price': price,
      'address': address?.toMap(),
    } as Map<String, dynamic>;
  }

//</editor-fold>

}

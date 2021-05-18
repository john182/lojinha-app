class ItemSize {
  String name;
  num price;
  int stock;

  ItemSize({required this.name, required this.price, required this.stock});

  factory ItemSize.fromMap(Map<String, dynamic> map) {
    return ItemSize(
      name: map['name'] as String,
      price: map['price'] as num,
      stock: map['stock'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'stock': stock,
    };
  }

  ItemSize clone() {
    return ItemSize(
      name: name,
      price: price,
      stock: stock,
    );
  }

  bool get hasStock => stock > 0;

  @override
  String toString() {
    return 'ItemSize{name: $name, price: $price, stock: $stock}';
  }
}

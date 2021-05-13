class ItemSize {
  String name;
  num price;
  int stock;

  ItemSize(this.name, this.price, this.stock);

  factory ItemSize.fromMap(Map<String, dynamic> map) {
    return ItemSize(
        map['name'] as String, map['price'] as num, map['stock'] as int);
  }

  bool get hasStock => stock > 0;

  @override
  String toString() {
    return 'ItemSize{name: $name, price: $price, stock: $stock}';
  }
}

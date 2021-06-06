import 'package:cloud_firestore/cloud_firestore.dart';

import 'item_size.dart';

class Product {
  String? id;
  String name;
  String description;
  List<String> images;
  List<dynamic>? newImages;
  List<ItemSize> sizes;

  Product(
      {this.id,
      required this.name,
      required this.description,
      required this.images,
      required this.sizes});

  factory Product.fromDocument(DocumentSnapshot document) {
    return Product(
        id: document.id,
        name: document['name'] as String,
        description: document['description'] as String,
        images: List<String>.from(document.get('images') as List<dynamic>),
        sizes: (document.get('sizes') as List<dynamic>)
            .map((s) => ItemSize.fromMap(s as Map<String, dynamic>))
            .toList());
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['id'] as String?,
        name: map['name'] as String,
        description: map['description'] as String,
        images: List<String>.from(map['images'] as List<dynamic>),
        sizes: (map['sizes'] as List<dynamic>)
            .map((s) => ItemSize.fromMap(s as Map<String, dynamic>))
            .toList());
  }

  List<Map<String, dynamic>> exportSizeList() {
    return sizes.map((size) => size.toMap()).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'sizes': exportSizeList(),
    };
  }

  Product clone() {
    return Product(
      id: id,
      name: name,
      description: description,
      images: List.from(images),
      sizes: sizes.map((size) => size.clone()).toList(),
    );
  }

  bool get hasNew => id == null;

  int get totalStock {
    int stock = 0;
    for (final size in sizes) {
      stock += size.stock;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0;
  }

  num get basePrice {
    num lowest = double.infinity;
    for (final size in sizes) {
      if (size.price < lowest && size.hasStock) {
        lowest = size.price;
      }
    }
    return lowest;
  }

  ItemSize? findSize(String name) {
    try {
      return sizes.firstWhere((s) => s.name == name);
    } catch (e) {
      return null;
    }
  }
}

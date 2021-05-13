class SectionItemModel {
  late String image;
  late String? product;

  SectionItemModel.fromMap(Map<String, dynamic> map) {
    image = map['image'] as String;
    product = map['product']?.toString();
  }

  @override
  String toString() {
    return 'SectionItem{image: $image}';
  }
}

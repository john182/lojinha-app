import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/model/section_item_model.dart';

class SectionModel {
  late String name;
  late String type;
  late List<SectionItemModel> items;

  SectionModel(this.name, this.type);

  SectionModel.fromDocument(DocumentSnapshot document) {
    name = document.get('name') as String;
    type = document.get('type') as String;
    items = (document.get('items') as List)
        .map((i) => SectionItemModel.fromMap(i as Map<String, dynamic>))
        .toList();
  }

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }
}

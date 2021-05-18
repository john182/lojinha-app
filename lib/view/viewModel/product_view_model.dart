import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/infra/locator.dart';
import 'package:loja_virtual/model/item_size.dart';
import 'package:loja_virtual/model/product.dart';
import 'package:loja_virtual/service/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  ItemSize? _selectedSize;

  ItemSize? get selectedSize => _selectedSize;

  final ProductService _service = locator<ProductService>();

  set selectedSize(ItemSize? value) {
    _selectedSize = value;
    notifyListeners();
  }

  Future<void> save(Product product) async {
    if (product.id == null) {
      final doc = await _service.add(product.toMap());
      product.id = doc.id;
    } else {
      await _service.update(product.toMap());
    }

    final List<String> updateImages = [];

    for (final newImage in product.newImages ?? []) {
      if (product.images.contains(newImage)) {
        updateImages.add(newImage as String);
      } else {
        final TaskSnapshot snapshot = await _service.upload(newImage);

        if (snapshot.state == TaskState.success) {
          final String url = await snapshot.ref.getDownloadURL();
          updateImages.add(url);
        }
      }
    }

    // for(final image in product.images){
    //   if(!(product.newImages??[]).contains(image)){
    //     try {
    //       final ref = await storage.getReferenceFromUrl(image);
    //       await ref.delete();
    //     } catch (e){
    //       debugPrint('Falha ao deletar $image');
    //     }
    //   }
    // }

    await _service.updateImages(updateImages);
  }

  Color getColorBorder(BuildContext context, ItemSize itemSize) {
    Color color;
    if (!itemSize.hasStock) {
      color = Colors.red.withAlpha(50);
    } else if (_selectedSize == itemSize) {
      color = Theme.of(context).primaryColor;
    } else {
      color = Colors.grey;
    }
    return color;
  }
}

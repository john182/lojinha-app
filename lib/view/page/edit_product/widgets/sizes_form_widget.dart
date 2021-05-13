import 'package:flutter/material.dart';
import 'package:loja_virtual/model/item_size.dart';
import 'package:loja_virtual/model/product.dart';
import 'package:loja_virtual/view/page/edit_product/widgets/edit_item_size_widget.dart';

class SizesFormWidget extends StatelessWidget {
  final Product product;

  const SizesFormWidget(this.product);

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
      initialValue: product.sizes,
      builder: (state) {
        return Column(
          children: state.value!.map((size) {
            return EditItemSizeWidget(size: size);
          }).toList(),
        );
      },
    );
  }
}

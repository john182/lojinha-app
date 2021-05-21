import 'package:flutter/material.dart';
import 'package:loja_virtual/model/section_item_model.dart';
import 'package:loja_virtual/ui/viewModel/products_view_model.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class SectionItemWidget extends StatelessWidget {
  final SectionItemModel item;

  const SectionItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.product != null) {
          final product =
              context.read<ProductsViewModel>().findProductById(item.product!);

          if (product != null) {
            Navigator.of(context).pushNamed('/product', arguments: product);
          }
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: item.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

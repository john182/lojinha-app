import 'package:flutter/material.dart';
import 'package:loja_virtual/model/ordem_item.dart';

class OrdersItemDatailWidget extends StatelessWidget {
  final OrderItem item;

  const OrdersItemDatailWidget({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/product', arguments: item.product);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 60,
              width: 60,
              child: Image.network(item.product!.images.first),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.product?.name ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                  Text(
                    'Tamanho: ${item.size}',
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    'R\$ ${(item.fixedPrice ?? 0).toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Text(
              '${item.quantity}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

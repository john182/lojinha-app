import 'package:flutter/material.dart';
import 'package:loja_virtual/model/item_size.dart';
import 'package:loja_virtual/ui/shared/widgets/icon_button_widget.dart';

class EditItemSizeWidget extends StatelessWidget {
  final ItemSize size;
  final VoidCallback onRemove;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;

  const EditItemSizeWidget(
      {Key? key,
      required this.size,
      required this.onRemove,
      this.onMoveUp,
      this.onMoveDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.name,
            decoration: const InputDecoration(
              labelText: 'Título',
              isDense: true,
            ),
            validator: (name) {
              if (name!.isEmpty) {
                return 'Inválido';
              }
              return null;
            },
            onChanged: (name) => size.name = name,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.stock.toString(),
            decoration: const InputDecoration(
              labelText: 'Estoque',
              isDense: true,
            ),
            keyboardType: TextInputType.number,
            validator: (stock) {
              if (int.tryParse(stock!) == null) {
                return 'Inválido';
              }
              return null;
            },
            onChanged: (stock) => size.stock = int.tryParse(stock)!,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size.price.toStringAsFixed(2),
            decoration: const InputDecoration(
              labelText: 'Preço',
              isDense: true,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (price) {
              if (num.tryParse(price!) == null) {
                return 'Inválido';
              }
              return null;
            },
            onChanged: (price) => size.price = num.tryParse(price)!,
          ),
        ),
        IconButtonWidget(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        IconButtonWidget(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        IconButtonWidget(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDown,
        )
      ],
    );
  }
}

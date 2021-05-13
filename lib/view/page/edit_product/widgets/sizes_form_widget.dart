import 'package:flutter/material.dart';
import 'package:loja_virtual/model/item_size.dart';
import 'package:loja_virtual/model/product.dart';
import 'package:loja_virtual/view/page/edit_product/widgets/edit_item_size_widget.dart';
import 'package:loja_virtual/view/shared/widgets/icon_button_widget.dart';

class SizesFormWidget extends StatelessWidget {
  final Product product;

  const SizesFormWidget(this.product);

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
      initialValue: List.from(product.sizes),
      validator: (sizes) {
        if (sizes!.isEmpty) {
          return 'Insira um tamanho';
        }
        return null;
      },
      builder: (state) {
        return Column(
          children: [
            Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    'Tamanhos',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                IconButtonWidget(
                  iconData: Icons.add,
                  color: Colors.black,
                  onTap: () {
                    state.value!.add(ItemSize("", 0, 0));
                    state.didChange(state.value);
                  },
                )
              ],
            ),
            Column(
              children: state.value!.map((size) {
                final index = state.value!.indexOf(size);
                return EditItemSizeWidget(
                  key: ObjectKey(size),
                  size: size,
                  onRemove: () {
                    state.value!.remove(size);
                    state.didChange(state.value);
                  },
                  onMoveDown: size == state.value!.last
                      ? null
                      : () {
                          moveItem(state, size, index + 1);
                        },
                  onMoveUp: size == state.value!.first
                      ? null
                      : () {
                          moveItem(state, size, index - 1);
                        },
                );
              }).toList(),
            ),
            if (state.hasError)
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              )
          ],
        );
      },
    );
  }

  void moveItem(
      FormFieldState<List<ItemSize>> state, ItemSize size, int position) {
    state.value!.remove(size);
    state.value!.insert(position, size);
    state.didChange(state.value);
  }
}

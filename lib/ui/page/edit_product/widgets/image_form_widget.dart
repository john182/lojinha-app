import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/model/product.dart';

import 'carousel_widget.dart';

class ImagesFormWidget extends StatelessWidget {
  final Product product;

  const ImagesFormWidget(this.product);

  @override
  Widget build(BuildContext context) {
    const int _currentIndex = 0;

    return FormField<List<dynamic>>(
      initialValue: List.from(product.images),
      validator: (images) {
        return images!.isEmpty ? 'Insira ao menos uma imagem' : null;
      },
      onSaved: (images) => product.newImages = images,
      builder: (state) {
        void onImageSelected(File file) {
          state.value?.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
                aspectRatio: 1.5,
                child: CarouselWidget(
                  images: state.value!,
                  onRemove: (image) {
                    state.value!.remove(image);
                    state.didChange(state.value);
                  },
                  onImageSelected: onImageSelected,
                )),
            if (state.hasError)
              Container(
                margin: const EdgeInsets.only(top: 8, left: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText ?? "",
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
}

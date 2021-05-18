import 'dart:io';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/model/product.dart';
import 'package:loja_virtual/view/page/edit_product/widgets/image_source_sheet_widget.dart';

class ImagesFormWidget extends StatelessWidget {
  final Product product;

  const ImagesFormWidget(this.product);

  @override
  Widget build(BuildContext context) {
    const int _currentIndex = 0;
    final double width = MediaQuery.of(context).size.width;
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
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                      ),
                      items: state.value!.map<Widget>((image) {
                        return Stack(fit: StackFit.expand, children: [
                          Container(
                            width: width,
                            decoration:
                                const BoxDecoration(color: Colors.green),
                            child: image is String
                                ? Image.network(image, fit: BoxFit.cover)
                                : Image.file(image as File, fit: BoxFit.cover),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: const Icon(Icons.remove),
                              color: Colors.red,
                              onPressed: () {
                                state.value!.remove(image);
                                state.didChange(state.value);
                              },
                            ),
                          )
                        ]);
                      }).toList()
                        ..add(Material(
                          color: Colors.black,
                          child: IconButton(
                            icon: const Icon(Icons.add_a_photo),
                            color: Theme.of(context).primaryColor,
                            iconSize: 50,
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) => ImageSourceSheetWidget(
                                        onImageSelected: onImageSelected,
                                      ));
                            },
                          ),
                        ))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: state.value!.map((imagem) {
                      final int index = state.value!.indexOf(imagem);
                      return Container(
                          width: 10.0,
                          height: 10.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? const Color.fromRGBO(0, 0, 0, 0.8)
                                : const Color.fromRGBO(0, 0, 0, 0.3),
                          ));
                    }).toList(),
                  )
                ],
              ),
            ),
            if (state.hasError)
              Container(
                margin: const EdgeInsets.only(top: 16, left: 16),
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
}

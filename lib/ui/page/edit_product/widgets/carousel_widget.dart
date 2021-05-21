import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/page/edit_product/widgets/dot_widget.dart';

import 'image_select_widget.dart';
import 'image_source_sheet_widget.dart';

class CarouselWidget extends StatelessWidget {
  final List images;
  final Function(dynamic image) onRemove;
  final Function(File) onImageSelected;

  const CarouselWidget(
      {Key? key,
      required this.images,
      required this.onRemove,
      required this.onImageSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CarouselSlider(
          options: CarouselOptions(
              enlargeCenterPage: true,
              disableCenter: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                _currentIndex = index;
              }),
          items: [
            ...images.map<Widget>((image) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Container(
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
                        onRemove(image);
                      },
                    ),
                  )
                ],
              );
            }).toList(),
            ImageSelectWidget(onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) => ImageSourceSheetWidget(
                        onImageSelected: onImageSelected,
                      ));
            }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.map((imagem) {
            final int index = images.indexOf(imagem);
            final selected = _currentIndex == index;
            return DotWidget(
              selected: selected,
            );
          }).toList()
            ..add(DotWidget()),
        )
      ],
    );
  }
}

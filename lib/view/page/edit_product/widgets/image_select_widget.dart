import 'package:flutter/material.dart';

class ImageSelectWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const ImageSelectWidget({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: IconButton(
        icon: const Icon(Icons.add_a_photo),
        color: Theme.of(context).primaryColor,
        iconSize: 50,
        onPressed: onPressed,
      ),
    );
  }
}

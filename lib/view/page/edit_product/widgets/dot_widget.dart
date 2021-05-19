import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  final bool selected;

  const DotWidget({Key? key, this.selected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.0,
      height: 10.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected
            ? const Color.fromRGBO(0, 0, 0, 0.8)
            : const Color.fromRGBO(0, 0, 0, 0.3),
      ),
    );
    ;
  }
}

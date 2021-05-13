import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final VoidCallback? onTap;

  const IconButtonWidget(
      {Key? key, required this.iconData, required this.color, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
              iconData,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

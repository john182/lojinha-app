import 'package:flutter/material.dart';
import 'package:loja_virtual/model/section_model.dart';

class SectionHeaderWidget extends StatelessWidget {
  final SectionModel section;

  const SectionHeaderWidget(this.section);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        section.name,
        style: const TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
    );
  }
}

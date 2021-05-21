import 'package:flutter/material.dart';
import 'package:loja_virtual/model/section_model.dart';
import 'package:loja_virtual/ui/page/home/widget/section_header_widget.dart';
import 'package:loja_virtual/ui/page/home/widget/section_item_widget.dart';

class SectionListWidget extends StatelessWidget {
  final SectionModel section;

  const SectionListWidget({Key? key, required this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeaderWidget(section),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return SectionItemWidget(section.items[index]);
              },
              separatorBuilder: (_, __) => const SizedBox(
                width: 4,
              ),
              itemCount: section.items.length,
            ),
          )
        ],
      ),
    );
  }
}

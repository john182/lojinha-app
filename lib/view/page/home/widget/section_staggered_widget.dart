import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loja_virtual/model/section_model.dart';
import 'package:loja_virtual/view/page/home/widget/section_header_widget.dart';
import 'package:loja_virtual/view/page/home/widget/section_item_widget.dart';

class SectionStaggeredWidget extends StatelessWidget {
  final SectionModel section;

  const SectionStaggeredWidget(this.section);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeaderWidget(section),
          StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            crossAxisCount: 4,
            itemCount: section.items.length,
            itemBuilder: (_, index) {
              return SectionItemWidget(section.items[index]);
            },
            staggeredTileBuilder: (index) =>
                StaggeredTile.count(2, index.isEven ? 2 : 1),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          )
        ],
      ),
    );
  }
}

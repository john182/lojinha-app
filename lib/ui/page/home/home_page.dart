import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/shared/menu/menu_widget.dart';
import 'package:loja_virtual/ui/viewModel/home_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(),
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Loja do Daniel'),
                  centerTitle: true,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  ),
                ],
              ),
              Consumer<HomeViewModel>(
                builder: (_, viewModel, __) {
                  final List<Widget> children =
                      viewModel.sections.map<Widget>((section) {
                    return Container();
                    // if (section.type == 'List') {
                    //   return SectionListWidget(section: section);
                    // }
                    //
                    // return SectionStaggeredWidget(section);
                  }).toList();

                  return SliverList(
                    delegate: SliverChildListDelegate(children),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

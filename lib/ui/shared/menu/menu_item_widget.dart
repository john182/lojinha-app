import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/viewModel/page_view_model.dart';
import 'package:provider/provider.dart';

class MenuItemWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final int page;

  const MenuItemWidget(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int currentPage = context.watch<PageViewModel>().page;

    final Color? color =
        currentPage == page ? Colors.green[700] : Colors.grey[700];

    return InkWell(
      onTap: () {
        context.read<PageViewModel>().setPage(page);
      },
      child: SizedBox(
          height: 60,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Icon(iconData, size: 32, color: color),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 16, color: color),
              )
            ],
          )),
    );
  }
}

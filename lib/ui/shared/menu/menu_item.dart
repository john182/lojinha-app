import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/viewModel/page_manager.dart';
import 'package:provider/provider.dart';

class MenuItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final int page;

  const MenuItem(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int currentPage = context.watch<PageManage>().page;

    final Color? color =
        currentPage == page ? Colors.green[700] : Colors.grey[700];

    return InkWell(
      onTap: () {
        context.read<PageManage>().setPage(page);
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

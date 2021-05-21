import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/shared/widgets/icon_button_widget.dart';

class CepLabelInfoWidget extends StatelessWidget {
  final String cep;
  final VoidCallback? onTap;

  const CepLabelInfoWidget({Key? key, required this.cep, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'CEP: $cep',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
            IconButtonWidget(
              iconData: Icons.edit,
              color: Theme.of(context).primaryColor,
              size: 20,
              onTap: onTap,
            ),
          ],
        ));
  }
}

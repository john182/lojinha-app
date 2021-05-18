import 'package:flutter/material.dart';
import 'package:loja_virtual/model/product.dart';
import 'package:loja_virtual/view/page/edit_product/widgets/image_form_widget.dart';
import 'package:loja_virtual/view/page/edit_product/widgets/sizes_form_widget.dart';
import 'package:loja_virtual/view/viewModel/product_view_model.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatelessWidget {
  final Product product;

  EditProduct(this.product);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    var viwModel = Provider.of<ProductViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.hasNew ? 'Criar Anúncio' : 'Editar Anúncio'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            ImagesFormWidget(product),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    initialValue: product.name,
                    decoration: const InputDecoration(
                      hintText: 'Título',
                      border: InputBorder.none,
                    ),
                    onSaved: (name) => product.name = name ?? "",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                    validator: (name) {
                      return name!.length < 6 ? 'Título muito curto' : null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ ...',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'Descrição',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextFormField(
                    initialValue: product.description,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                        hintText: 'Descrição', border: InputBorder.none),
                    maxLines: null,
                    onSaved: (desc) => product.description = desc ?? "",
                    validator: (desc) {
                      return desc!.length < 10 ? 'Descrição muito curta' : null;
                    },
                  ),
                  SizesFormWidget(product),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          viwModel.save(product);
                        }
                      },
                      child: const Text('Salvar'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

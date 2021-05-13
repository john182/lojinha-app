import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheetWidget extends StatelessWidget {
  final Function(File) onImageSelected;

  ImageSourceSheetWidget({Key? key, required this.onImageSelected})
      : super(key: key);

  final ImagePicker picker = ImagePicker();

  Future<void> editImage(String path, BuildContext context) async {
    final File? croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Editar Imagem',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
        ),
        iosUiSettings: const IOSUiSettings(
          title: 'Editar Imagem',
          cancelButtonTitle: 'Cancelar',
          doneButtonTitle: 'Concluir',
        ));
    if (croppedFile != null) {
      onImageSelected(croppedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? BottomSheetAndroidWidget(onImageSelected: onImageSelected)
        : CupertinoActionSheet(
            title: const Text('Selecionar foto para o item'),
            message: const Text('Escolha a origem da foto'),
            cancelButton: CupertinoActionSheetAction(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancelar'),
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () async {
                  final PickedFile? file =
                      await picker.getImage(source: ImageSource.camera);
                  if (file != null) {
                    editImage(file.path, context);
                  }
                },
                child: const Text('Câmera'),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  final PickedFile? file =
                      await picker.getImage(source: ImageSource.gallery);
                  if (file != null) {
                    editImage(file.path, context);
                  }
                },
                child: const Text('Galeria'),
              ),
            ],
          );
  }
}

class BottomSheetAndroidWidget extends StatelessWidget {
  final Function(File) onImageSelected;

  BottomSheetAndroidWidget({Key? key, required this.onImageSelected})
      : super(key: key);

  final ImagePicker picker = ImagePicker();

  Future<void> editImage(String path, BuildContext context) async {
    final File? croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Editar Imagem',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
        ),
        iosUiSettings: const IOSUiSettings(
          title: 'Editar Imagem',
          cancelButtonTitle: 'Cancelar',
          doneButtonTitle: 'Concluir',
        ));
    if (croppedFile != null) {
      onImageSelected(croppedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextButton(
            onPressed: () async {
              final PickedFile? file =
                  await picker.getImage(source: ImageSource.camera);
              if (file != null) {
                editImage(file.path, context);
              }
            },
            child: const Text('Câmera'),
          ),
          TextButton(
            onPressed: () async {
              final PickedFile? file =
                  await picker.getImage(source: ImageSource.gallery);
              if (file != null) {
                editImage(file.path, context);
              }
            },
            child: const Text('Galeria'),
          ),
        ],
      ),
    );
  }
}

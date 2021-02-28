import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:products/ui/widgets/base_text.dart';
import 'package:products/domain/models/product.dart';
import 'package:products/ui/widgets/dialog_button.dart';
import 'package:products/ui/widgets/loading_circle.dart';

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: LoadingCircle(),
        ),
      );
    },
    barrierDismissible: false,
  );
}

showConfirmDeleteProductDialog(
    BuildContext context, Product product, Function deleteFun) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        elevation: 0,
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseText(
                'Você realmente desejar excluir o produto ${product.name}?',
                fontSize: 18,
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DialogButton(
                    text: 'Cancelar',
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    onTap: () => popDialog(context),
                  ),
                  SizedBox(width: 16),
                  DialogButton(
                    text: 'Confirmar',
                    backgroundColor: Colors.deepOrange,
                    onTap: () {
                      deleteFun(product.id);
                      popDialog(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
    barrierDismissible: true,
  );
}

showSelectImageTypeDialog(
    BuildContext context, Function(ImageSource) pickImage) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        elevation: 0,
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseText(
                'Você deseja escolher uma foto da galeria ou tirar foto com a câmera?',
                fontSize: 18,
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DialogButton(
                    text: 'Galeria',
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      popDialog(context);
                    },
                  ),
                  SizedBox(width: 16),
                  DialogButton(
                    text: 'Câmera',
                    backgroundColor: Colors.deepOrange,
                    onTap: () {
                      pickImage(ImageSource.camera);
                      popDialog(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
    barrierDismissible: true,
  );
}

popDialog(BuildContext context) {
  Navigator.pop(context);
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:products/ui/widgets/app_bar.dart';
import 'package:products/utils/dialog_utils.dart';
import 'package:products/ui/widgets/base_text.dart';
import 'package:products/domain/models/product.dart';
import 'package:products/domain/dto/product_dto.dart';
import 'package:products/ui/widgets/base_form_field.dart';
import 'package:products/domain/dto/update_product_dto.dart';
import 'package:products/ui/providers/products_provider.dart';

class AddProductPage extends StatefulWidget {
  static const String routeName = 'add-product-page';

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _priceController = new TextEditingController();

  Product productToEdit;

  File pickedImage;

  @override
  Widget build(BuildContext context) {
    productToEdit = ModalRoute.of(context).settings.arguments;

    if (_nameController.text.isEmpty &&
        _priceController.text.isEmpty &&
        productToEdit != null) {
      _nameController.text = productToEdit.name;
      _priceController.text = productToEdit.price.toString();
    }

    return Scaffold(
      appBar: appBar(
        context: context,
        title: productToEdit == null ? 'Adicionar Produto' : 'Editar Produto',
        removeIcon: true,
        withBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                BaseFormField(
                  _nameController,
                  hint: 'Nome',
                  validator: nameValidator,
                ),
                SizedBox(height: 8),
                BaseFormField(
                  _priceController,
                  hint: 'Preço',
                  inputType: TextInputType.number,
                  validator: priceValidator,
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: handleSelectImage,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseText(
                          'Escolher imagem',
                          fontSize: 18,
                          isBold: true,
                        ),
                        Visibility(
                          visible: (productToEdit != null &&
                                  productToEdit.image_path != null) ||
                              pickedImage != null,
                          child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              SizedBox(height: 32),
                              pickedImage != null
                                  ? Image.file(
                                      pickedImage,
                                      height: 250,
                                    )
                                  : productToEdit != null &&
                                          productToEdit.image_path != null
                                      ? Image.network(
                                          productToEdit.image_path,
                                          height: 250,
                                        )
                                      : Container(),
                              SizedBox(height: 16),
                              GestureDetector(
                                onTap: clearPickedImage,
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: BaseText(
                                    'Remover Imagem',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: handleFinish,
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(top: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    child: BaseText(
                      productToEdit != null ? 'Editar' : 'Adicionar',
                      color: Colors.white,
                      isBold: true,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  clearPickedImage() {
    setState(() {
      pickedImage = null;
      productToEdit.image_path = null;
    });
  }

  handleSelectImage() {
    showSelectImageTypeDialog(context, handlePickImage);
  }

  handlePickImage(ImageSource source) async {
    final image = await ImagePicker().getImage(source: source);

    setState(() {
      pickedImage = File(image.path);
    });
  }

  String nameValidator(String value) {
    if (value.isEmpty) {
      return 'Você precisa inserir o nome!';
    }

    return null;
  }

  String priceValidator(String value) {
    if (value.isEmpty) {
      return 'Você precisa inserir o preço!';
    }

    try {
      double price = double.parse(value);

      if (price < 1) {
        return 'O valor mínimo é 1 real!';
      }
    } catch (e) {
      return 'Vocẽ precisa inserir um número válido!';
    }

    return null;
  }

  handleFinish() async {
    bool formIsValidated = _formKey.currentState.validate();

    if (formIsValidated) {
      String name = _nameController.text;
      double price = double.parse(_priceController.text);

      showLoadingDialog(context);

      ProductsProvider provider = Provider.of<ProductsProvider>(
        context,
        listen: false,
      );

      if (productToEdit == null) {
        ProductDTO dto = new ProductDTO(
          name: name,
          price: price,
          image: pickedImage,
        );

        await provider.add(dto);
      } else {
        UpdateProductDTO dto = new UpdateProductDTO(
          id: productToEdit.id,
          name: name,
          price: price,
          image: pickedImage,
          image_path: pickedImage != null ? null : productToEdit.image_path,
        );

        await provider.update(dto);
      }

      _nameController.text = '';
      _priceController.text = '';

      popDialog(context);

      await provider.fetch();

      Navigator.pop(context);
    }
  }
}

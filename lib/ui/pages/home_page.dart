import 'package:flutter/material.dart';
import 'package:products/domain/models/product.dart';
import 'package:products/ui/pages/add_product_page.dart';
import 'package:products/ui/providers/products_provider.dart';
import 'package:products/ui/widgets/app_bar.dart';
import 'package:products/ui/widgets/base_text.dart';
import 'package:products/ui/widgets/loading_circle.dart';
import 'package:products/ui/widgets/product_item.dart';
import 'package:products/utils/dialog_utils.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home-page';

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BaseText(
                    'Lista de Produtos',
                    fontSize: 24,
                    isBold: true,
                    color: Colors.deepOrange,
                  ),
                  Wrap(children: [
                    GestureDetector(
                      onTap: refreshProductList,
                      child: Icon(
                        Icons.refresh,
                        color: Colors.deepOrange,
                        size: 32,
                      ),
                    ),
                    SizedBox(width: 16),
                    GestureDetector(
                      onTap: toAddProductPage,
                      child: Icon(
                        Icons.add,
                        color: Colors.deepOrange,
                        size: 32,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            SizedBox(height: 16),
            Consumer<ProductsProvider>(
              builder: (context, provider, widget) {
                if (provider.isLoading) {
                  return LoadingCircle();
                } else if (!provider.isLoading && provider.data == null) {
                  provider.fetch();

                  return LoadingCircle();
                } else if (!provider.isLoading &&
                    provider.error != null &&
                    provider.error.isNotEmpty) {
                  return makeInfoText(
                    "Um erro aconteceu: ${provider.error}",
                  );
                } else if (!provider.isLoading && provider.data.isEmpty) {
                  return makeInfoText(
                    "Nenhum produto foi encontrado. Adicione um!",
                  );
                }

                return Flexible(
                  child: ListView.builder(
                    itemCount: provider.data.length,
                    itemBuilder: (context, index) {
                      return ProductItem(
                        product: provider.data[index],
                        handleDelete: handleDelete,
                        handleEdit: handleEdit,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  makeInfoText(String text) {
    return BaseText(
      text,
      fontSize: 18,
      color: Colors.black,
    );
  }

  refreshProductList() async {
    await Provider.of<ProductsProvider>(context, listen: false).fetch();
  }

  toAddProductPage() {
    Navigator.pushNamed(context, AddProductPage.routeName);
  }

  handleEdit(Product product) {
    Navigator.pushNamed(context, AddProductPage.routeName, arguments: product);
  }

  handleDelete(Product product) {
    showConfirmDeleteProductDialog(context, product, deleteProduct);
  }

  deleteProduct(int id) async {
    showLoadingDialog(context);

    await Provider.of<ProductsProvider>(context, listen: false).delete(id);

    await refreshProductList();

    popDialog(context);
  }
}

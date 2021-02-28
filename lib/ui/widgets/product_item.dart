import 'package:flutter/material.dart';
import 'package:products/domain/models/product.dart';
import 'package:products/ui/widgets/base_text.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final Function handleDelete;
  final Function handleEdit;

  ProductItem({
    this.product,
    this.handleEdit,
    this.handleDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
            spreadRadius: .1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            product.image_path != null
                ? Container(
                    height: 80,
                    width: 80,
                    margin: EdgeInsets.only(
                      right: 8,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Image.network(product.image_path),
                    ),
                  )
                : Container(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  product.name,
                  fontSize: 18,
                  color: Colors.black87,
                  isBold: true,
                ),
                BaseText(
                  'R\$ ${product.price}',
                  fontSize: 24,
                  color: Colors.black87,
                ),
              ],
            ),
          ]),
          Wrap(
            children: [
              GestureDetector(
                onTap: () => handleDelete(product),
                child: Icon(
                  Icons.delete_forever,
                  size: 32,
                  color: Colors.deepOrange,
                ),
              ),
              SizedBox(width: 16),
              GestureDetector(
                onTap: () => handleEdit(product),
                child: Icon(
                  Icons.edit,
                  size: 32,
                  color: Colors.deepOrange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:products/ui/widgets/base_text.dart';

appBar({
  BuildContext context,
  String title = 'Products',
  bool removeIcon = false,
  bool withBackButton = false,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    leading: !withBackButton
        ? null
        : GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.deepOrange,
              size: 32,
            ),
          ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: !removeIcon,
          child: Wrap(
            children: [
              Icon(
                Icons.shop_two,
                color: Colors.deepOrange,
              ),
              SizedBox(width: 8),
            ],
          ),
          replacement: Container(),
        ),
        BaseText(
          title,
          fontSize: 24,
          isBold: true,
          color: Colors.deepOrange,
        ),
      ],
    ),
    centerTitle: true,
  );
}

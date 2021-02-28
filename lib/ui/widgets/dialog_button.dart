import 'package:flutter/material.dart';
import 'package:products/ui/widgets/base_text.dart';

class DialogButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color backgroundColor;
  final Color textColor;

  DialogButton({
    this.text,
    this.onTap,
    this.backgroundColor,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: this.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black26,
            ),
          ],
        ),
        child: BaseText(
          this.text,
          isBold: true,
          color: textColor,
        ),
      ),
    );
  }
}

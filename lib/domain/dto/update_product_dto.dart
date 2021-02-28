import 'dart:io';

class UpdateProductDTO {
  int id;
  String name;
  double price;
  File image;
  String image_path;

  UpdateProductDTO({
    this.id,
    this.name,
    this.price,
    this.image,
    this.image_path,
  });
}

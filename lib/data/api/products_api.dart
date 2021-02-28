import 'dart:convert';

import 'package:products/data/api/client.dart';
import 'package:products/domain/dto/product_dto.dart';
import 'package:products/domain/dto/update_product_dto.dart';

class ProductsApi {
  findAll() async {
    dynamic response = await ClientApi().get('core/products');

    return response;
  }

  add(ProductDTO dto) async {
    final request = ClientApi().getMultipartRequest('POST', 'core/products');

    request.fields['name'] = dto.name;
    request.fields['price'] = dto.price.toString();

    var image;

    if (dto.image != null) {
      image = await ClientApi().getMultipartFile('image', dto.image);

      request.files.add(image);
    }

    final response = await request.send();

    final body = await ClientApi().getStreamedBody(response);

    return body;
  }

  update(UpdateProductDTO dto) async {
    final request =
        ClientApi().getMultipartRequest('PUT', 'core/products/${dto.id}');

    request.fields['id'] = dto.id.toString();
    request.fields['name'] = dto.name;
    request.fields['price'] = dto.price.toString();

    var image;

    if (dto.image != null) {
      image = await ClientApi().getMultipartFile('image', dto.image);

      request.files.add(image);
    } else if (dto.image_path != null) {
      request.fields['image_path'] = dto.image_path;
    }

    final response = await request.send();

    final body = await ClientApi().getStreamedBody(response);

    return body;
  }

  delete(int id) async {
    dynamic response = await ClientApi().delete('core/products/$id');

    return response;
  }

  createBodyFromProductDTO(ProductDTO dto) {
    dynamic body = {};

    body['name'] = dto.name;
    body['price'] = dto.price;

    return body;
  }

  createBodyFromUpdateProductDTO(UpdateProductDTO dto) {
    Map body = {};

    body['id'] = dto.id;
    body['name'] = dto.name;
    body['price'] = dto.price;

    return body;
  }
}

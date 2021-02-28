import 'package:products/data/api/products_api.dart';
import 'package:products/domain/dto/product_dto.dart';
import 'package:products/domain/dto/update_product_dto.dart';

class Facade {
  Future<Map> findAllProducts() async {
    return await ProductsApi().findAll();
  }

  addProduct(ProductDTO dto) async {
    return await ProductsApi().add(dto);
  }

  updateProduct(UpdateProductDTO dto) async {
    return await ProductsApi().update(dto);
  }

  deleteProduct(int id) async {
    return await ProductsApi().delete(id);
  }
}

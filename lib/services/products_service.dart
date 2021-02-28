import 'package:products/data/facade.dart';
import 'package:products/services/base_service.dart';
import 'package:products/domain/models/product.dart';
import 'package:products/domain/dto/product_dto.dart';
import 'package:products/domain/dto/update_product_dto.dart';
import 'package:products/domain/models/service_response.dart';

class ProductsService extends BaseService {
  findAll() async {
    ServiceResponse response = new ServiceResponse<List<Product>>();

    try {
      Map result = await Facade().findAllProducts();

      response.data = result['data'].map<Product>((e) {
        return new Product(
          id: e['id'],
          name: e['name'],
          price: double.parse(e['price'].toString()),
          image_path: e['image_path'],
        );
      }).toList();
    } catch (e) {
      response.data = new List<Product>();
      response.error = treatError(e);
    }

    return response;
  }

  add(ProductDTO dto) async {
    ServiceResponse response = new ServiceResponse<Map>();

    try {
      response.data = await Facade().addProduct(dto);
    } catch (e) {
      response.error = treatError(e);
    }

    return response;
  }

  update(UpdateProductDTO dto) async {
    ServiceResponse response = new ServiceResponse<Map>();

    try {
      response.data = await Facade().updateProduct(dto);
    } catch (e) {
      response.error = treatError(e);
    }

    return response;
  }

  delete(int id) async {
    ServiceResponse response = new ServiceResponse<Map>();

    try {
      response.data = await Facade().deleteProduct(id);
    } catch (e) {
      response.error = treatError(e);
    }

    return response;
  }
}

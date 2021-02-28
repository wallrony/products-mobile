import 'package:products/domain/models/product.dart';
import 'package:products/domain/dto/product_dto.dart';
import 'package:products/services/products_service.dart';
import 'package:products/ui/providers/custom_provider.dart';
import 'package:products/domain/dto/update_product_dto.dart';
import 'package:products/domain/models/service_response.dart';

class ProductsProvider extends CustomProvider<List<Product>> {
  Future<void> fetch() async {
    setError(null);

    setIsLoading = true;

    ServiceResponse<List<Product>> response = await ProductsService().findAll();

    treatDataResponse(response);

    setIsLoading = false;
  }

  Future<bool> add(ProductDTO dto) async {
    ServiceResponse<Map> response = await ProductsService().add(dto);

    return treatBooleanResponse(response);
  }

  update(UpdateProductDTO dto) async {
    ServiceResponse<Map> response = await ProductsService().update(dto);

    return treatBooleanResponse(response);
  }

  delete(int id) async {
    ServiceResponse<Map> response = await ProductsService().delete(id);

    return treatBooleanResponse(response);
  }
}

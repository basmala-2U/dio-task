import 'package:dio/dio.dart';
import '../network/dio_config.dart';
import '../network/api_constants.dart';
import '../models/product_model.dart';

class ApiService {
  final Dio dio = DioConfig.getDio();

  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get(ApiConstants.products);

    List productsJson = response.data['products'];

    return productsJson.map((json) => ProductModel.fromJson(json)).toList();
  }
}

import 'package:dio/dio.dart';
import '../network/dio_config.dart';
import '../network/api_constants.dart';
import '../models/product_model.dart';

// service class responsible for api calls
class ApiService {
  // dio instance configured from dio config
  final Dio dio = DioConfig.getDio();

  // fetch products from api and convert them to product model list
  Future<List<ProductModel>> getProducts() async {
    // send get request to products endpoint
    final response = await dio.get(ApiConstants.products);

    // extract products list from response json
    List productsJson = response.data['products'];

    // convert json list to product model objects
    return productsJson.map((json) => ProductModel.fromJson(json)).toList();
  }
}

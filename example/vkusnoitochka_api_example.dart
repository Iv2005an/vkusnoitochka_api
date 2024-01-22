import 'package:vkusnoitochka_api/vkusnoitochka_api.dart';

void main() async {
  final vitCityId =
      (await VIT.getCities()).data?['items']?[0]?['id'].toString();
  if (vitCityId == null || vitCityId.isEmpty) throw Exception('City not found');

  final List<dynamic>? products =
      (await VIT.getProducts(vitCityId)).data?["items"];
  if (products == null || products.isEmpty) {
    throw Exception('Products not found');
  }

  final Map<String, dynamic>? product = products.first;
  if (product == null || product.entries.isEmpty) {
    throw Exception('Product not found');
  }

  print("""Id: ${product['id']}
Title: ${product['name']}
Image URL: ${product['imagesAndroidLarge']['l']}""");
}

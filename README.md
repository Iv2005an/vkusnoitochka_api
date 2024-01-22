API for receiving data from Vkusnoitochka. The library has a class with static methods for retrieving data.

## Usage

Receive a dio response from Vkusnoitochka with information about restaurants, and outputting the request data to the console:

```dart
import 'package:vkusnoitochka_api/vkusnoitochka_api.dart';

void main() async {
  final vitRestaurants = await VIT.getRestaurants();
  print('vitRestaurants: $vitRestaurants');
}
```

Output of product data:

```dart
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

OUTPUT:
Id: 6490d1a87dc0552dc1a8408d
Title: Латте Ваниль
Image URL: https://ma-prod.cdn.vkusnoitochka.ru/product/2e3c64a0580041499c7e3e10b152f645/android/l/large.png
```
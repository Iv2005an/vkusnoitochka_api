import 'dart:math';

import 'package:dio/dio.dart';

class VIT {
  /// URL for getting information about the user's loyalty from Vkusnoitochka
  static const loyaltyUserUrl =
      'https://mobile-api.vkusnoitochka.ru/api/v1/loyalty/user';

  /// URL for getting the app version from Vkusnoitochka
  static const forceUpdateUrl =
      'https://mobile-api.vkusnoitochka.ru/api/v1/info/force-update';

  /// URL for getting information about cities from Vkusnoitochka
  static const citiesUrl =
      'https://mobile-api.vkusnoitochka.ru/api/v1/catalog/cities';

  /// URL for getting information about restaurants from Vkusnoitochka
  static const restaurantsUrl =
      'https://mobile-api.vkusnoitochka.ru/api/v1/catalog/restaurants';

  /// URL for getting information about the catalog from Vkusnoitochka
  static const catalogUrl =
      'https://mobile-api.vkusnoitochka.ru/api/v1/catalog/catalog';

  /// URL for getting information about products from Vkusnoitochka
  static const productsUrl =
      'https://mobile-api.vkusnoitochka.ru/api/v1/catalog/products';

  /// URL for getting information about subscriptions from Vkusnoitochka
  static const subscriptionsUrl =
      'https://mobile-api.vkusnoitochka.ru/api/v1/subscriptions/user';

  /// URL for getting information about the advent config from Vkusnoitochka
  static const adventConfigUrl =
      'https://mobile-api.vkusnoitochka.ru/api/v1/advent/config';

  /// URL for getting information about the bigfest config from Vkusnoitochka
  static const bigfestConfigUrl =
      'https://mobile-api.vkusnoitochka.ru/api/v1/bigfest/config';

  /// URL for getting information about the charity config from Vkusnoitochka
  static const charityConfigUrl =
      'https://mobile-api.vkusnoitochka.ru/api/v1/charity/config';

  /// URL for getting information about the delivery config from Vkusnoitochka
  static const deliveryConfigUrl =
      'https://mobile-api.vkusnoitochka.ru/api/v1/dff/config';

  /// URL for getting information about the order config from Vkusnoitochka
  static const orderConfigUrl =
      'https://mobile-api.vkusnoitochka.ru/api/v1/order/config';

  /// URL for getting information about monopoly stickers from Vkusnoitochka
  static const monopolyStickersUrl =
      'https://mobile-api.vkusnoitochka.ru/api/v1/monopoly/stickers';

  static final _httpClient = Dio();

  static String _testCityId(String cityId) {
    if (cityId.isNotEmpty && !RegExp(r'^(\d|[a-f]){24}$').hasMatch(cityId)) {
      throw Exception('Invalid cityId');
    }
    return cityId;
  }

  /// Getting headers to receive data from Vkusnoitochka
  ///
  /// [cityId] is ID of Vkusnoitochka city,
  /// that has the mask "ffffffffffffffffffffffff".
  /// It maybe is empty string if city is unimportant.
  ///
  /// [deviceId] is ID of the device, that has the mask "ffffffffffffffff".
  /// If the [deviceId] is not specified, it is generated automatically.
  /// If [deviceId] is incorrect, throws [Exception]
  static Map<String, String> getApiHeaders(
      {String cityId = '', String deviceId = ''}) {
    _testCityId(cityId);
    if (deviceId.isNotEmpty &&
        !RegExp(r'^(\d|[a-f]){16}$').hasMatch(deviceId)) {
      throw Exception('Invalid deviceId');
    }
    Random random = Random();
    if (deviceId.isEmpty) {
      for (var i = 0; i < 16; i++) {
        deviceId += random.nextInt(16).toRadixString(16);
      }
    }
    return {
      'X-Device-ID': deviceId,
      'X-City-ID': cityId,
    };
  }

  /// Getting information about user loyalty from Vkusnoitochka
  ///
  /// [cityId] is ID of Vkusnoitochka city,
  /// that has the mask "ffffffffffffffffffffffff".
  /// It maybe is empty string if city is unimportant.
  static Future<Response> getLoyaltyUser([String cityId = '']) async =>
      await _httpClient.get(loyaltyUserUrl,
          options: Options(headers: getApiHeaders(cityId: cityId)));

  /// Getting the app version from Vkusnoitochka
  static Future<Response> getForceUpdate() async => await _httpClient
      .get(forceUpdateUrl, options: Options(headers: getApiHeaders()));

  /// Getting information about cities from Vkusnoitochka
  ///
  /// [modifiedTime] is necessary to get data changed since that time
  static Future<Response> getCities([int modifiedTime = 0]) async =>
      await _httpClient.get(citiesUrl,
          queryParameters: {'modified': modifiedTime},
          options: Options(headers: getApiHeaders()));

  /// Getting information about restaurants from Vkusnoitochka
  ///
  /// [modifiedTime] is necessary to get data changed since that time
  static Future<Response> getRestaurants([int modifiedTime = 0]) async =>
      await _httpClient.get(restaurantsUrl,
          queryParameters: {'modified': modifiedTime},
          options: Options(headers: getApiHeaders()));

  /// Getting URL for receive banners from Vkusnoitochka
  ///
  /// [cityId] is ID of Vkusnoitochka city,
  /// that has the mask "ffffffffffffffffffffffff"
  static String getBannersUrl(String cityId) =>
      'https://mobile-api.vkusnoitochka.ru/api/v1/catalog/banners?city_id=${_testCityId(cityId)}';

  /// Getting banners from Vkusnoitochka
  ///
  /// [cityId] is ID of Vkusnoitochka city,
  /// that has the mask "ffffffffffffffffffffffff"
  static Future<Response> getBanners(String cityId) async =>
      await _httpClient.get(getBannersUrl(cityId),
          options: Options(headers: getApiHeaders(cityId: cityId)));

  /// Getting URL for receive offers from Vkusnoitochka
  ///
  /// [cityId] is ID of Vkusnoitochka city,
  /// that has the mask "ffffffffffffffffffffffff"
  static String getOffersUrl(String cityId) =>
      'https://mobile-api.vkusnoitochka.ru/api/v1/offers?city=${_testCityId(cityId)}';

  /// Getting offers from Vkusnoitochka
  ///
  /// [cityId] is ID of Vkusnoitochka city,
  /// that has the mask "ffffffffffffffffffffffff"
  static Future<Response> getOffers(String cityId) async =>
      await _httpClient.get(getOffersUrl(cityId),
          options: Options(headers: getApiHeaders(cityId: cityId)));

  /// Getting subscriptions from Vkusnoitochka
  ///
  /// [cityId] is ID of Vkusnoitochka city,
  /// that has the mask "ffffffffffffffffffffffff"
  static Future<Response> getSubscriptions(String cityId) async =>
      await _httpClient.get(subscriptionsUrl,
          options: Options(headers: getApiHeaders(cityId: cityId)));

  /// Getting catalog from Vkusnoitochka
  ///
  /// [cityId] is ID of Vkusnoitochka city,
  /// that has the mask "ffffffffffffffffffffffff".
  /// It maybe is empty string if city is unimportant
  /// [modifiedTime] is necessary to get data changed since that time
  static Future<Response> getCatalog(
          {String cityId = '', int modifiedTime = 0}) async =>
      await _httpClient.get(catalogUrl,
          queryParameters: {'modified': modifiedTime},
          options: Options(headers: getApiHeaders(cityId: cityId)));

  /// Getting products from Vkusnoitochka
  ///
  /// [cityId] is ID of Vkusnoitochka city,
  /// that has the mask "ffffffffffffffffffffffff".
  /// It maybe is empty string if city is unimportant
  /// [modifiedTime] is necessary to get data changed since that time
  static Future<Response> getProducts(
          {String cityId = '', int modifiedTime = 0}) async =>
      await _httpClient.get(productsUrl,
          queryParameters: {'modified': modifiedTime},
          options: Options(headers: getApiHeaders(cityId: cityId)));

  /// Getting URL for receive prices from Vkusnoitochka
  ///
  /// [cityId] is ID of Vkusnoitochka city,
  /// that has the mask "ffffffffffffffffffffffff"
  static String getPricesUrl(String cityId) =>
      'https://mobile-api.vkusnoitochka.ru/api/v1/order/prices/city?city_id=${_testCityId(cityId)}';

  /// Getting prices from Vkusnoitochka
  ///
  /// [cityId] is ID of Vkusnoitochka city,
  /// that has the mask "ffffffffffffffffffffffff"
  static Future<Response> getPrices(String cityId) async =>
      await _httpClient.get(getPricesUrl(cityId),
          options: Options(headers: getApiHeaders(cityId: cityId)));

  /// Getting advent config from Vkusnoitochka
  ///
  /// [cityId] is ID of Vkusnoitochka city,
  /// that has the mask "ffffffffffffffffffffffff"
  static Future<Response> getAdventConfig(String cityId) async =>
      await _httpClient.get(adventConfigUrl,
          options: Options(headers: getApiHeaders(cityId: cityId)));

  /// Getting bigfest config from Vkusnoitochka
  ///
  /// [cityId] is ID of Vkusnoitochka city,
  /// that has the mask "ffffffffffffffffffffffff"
  static Future<Response> getBigfestConfig(String cityId) async =>
      await _httpClient.get(bigfestConfigUrl,
          options: Options(headers: getApiHeaders(cityId: cityId)));

  /// Getting charity from Vkusnoitochka
  ///
  /// [cityId] is ID of Vkusnoitochka city,
  /// that has the mask "ffffffffffffffffffffffff".
  /// It maybe is empty string if city is unimportant
  static Future<Response> getCharityConfig([String cityId = '']) async =>
      await _httpClient.get(charityConfigUrl,
          options: Options(headers: getApiHeaders(cityId: cityId)));

  /// Getting prices from Vkusnoitochka
  ///
  /// [cityId] is ID of Vkusnoitochka city,
  /// that has the mask "ffffffffffffffffffffffff"
  /// [modifiedTime] is necessary to get data changed since that time
  static Future<Response> getDeliveryConfig(String cityId,
          [int modifiedTime = 0]) async =>
      await _httpClient.get(deliveryConfigUrl,
          queryParameters: {'modified': modifiedTime},
          options: Options(headers: getApiHeaders(cityId: cityId)));

  /// Getting prices from Vkusnoitochka
  ///
  /// [cityId] is ID of Vkusnoitochka city,
  /// that has the mask "ffffffffffffffffffffffff".
  /// It maybe is empty string if city is unimportant
  static Future<Response> getOrderConfig([String cityId = '']) async =>
      await _httpClient.get(orderConfigUrl,
          options: Options(headers: getApiHeaders(cityId: cityId)));

  /// Getting prices from Vkusnoitochka
  ///
  /// [cityId] is ID of Vkusnoitochka city,
  /// that has the mask "ffffffffffffffffffffffff".
  /// It maybe is empty string if city is unimportant
  static Future<Response> getMonopolyStickers([String cityId = '']) async =>
      await _httpClient.get(monopolyStickersUrl,
          options: Options(headers: getApiHeaders(cityId: cityId)));
}

import 'dart:convert';
import 'dart:io';

import 'package:vkusnoitochka_api/vkusnoitochka_api.dart';
import 'package:test/test.dart';

Future<void> saveJson(String fileName, dynamic data) async {
  final apiResponsesDirectory = Directory('api_responses');
  await apiResponsesDirectory.create();
  File file = File('${apiResponsesDirectory.path}/$fileName.json');
  await file.writeAsString(jsonEncode(data));
}

void main() async {
  group('VIT', () {
    test('getApiHeaders()', () async {
      final data = VIT.getApiHeaders();
      expect(data['X-Device-ID'], matches(r'^(\d|[a-f]){16}$'));
      await saveJson('getApiHeaders()', data);
    });
    test('getApiHeaders(cityId, deviceId)', () async {
      const cityId = '5dfc9fd451f0dc92455bee95';
      const deviceId = '12345678abcdef12';
      final data = VIT.getApiHeaders(cityId: cityId, deviceId: deviceId);
      expect(data['X-City-ID'], allOf(contains(cityId)));
      expect(data['X-Device-ID'], contains(deviceId));
      await saveJson('getApiHeaders(cityId, deviceId)', data);
    });
    test('getApiHeaders(invalidCityId)', () {
      expect(() => VIT.getApiHeaders(cityId: 'fffffffffffffffff'),
          throwsException);
    });
    test('getApiHeaders(invalidDeviceId)', () {
      expect(() => VIT.getApiHeaders(deviceId: 'fffffffffffffffff'),
          throwsException);
    });

    test('getLoyaltyUser()', () async {
      final data = (await VIT.getLoyaltyUser()).data;
      expect(data, isNotEmpty);
      await saveJson('getLoyaltyUser()', data);
    });

    test('getForceUpdate()', () async {
      final data = (await VIT.getForceUpdate()).data;
      expect(data, isNotEmpty);
      await saveJson('getForceUpdate()', data);
    });

    test('getCities()', () async {
      final data = (await VIT.getCities()).data;
      expect(data, isNotEmpty);
      await saveJson('getCities()', data);
    });

    test('getRestaurants()', () async {
      final data = (await VIT.getRestaurants()).data;
      expect(data, isNotEmpty);
      await saveJson('getRestaurants()', data);
    });

    test('getBannersUrl(cityId)', () async {
      final cityId = '5dfc9fd451f0dc92455bee95';
      final data = VIT.getBannersUrl(cityId);
      expect(data, isNotEmpty);
      await saveJson('getBannersUrl(cityId)', data);
    });
    test('getBannersUrl(invalidCityId)', () async {
      expect(
          () => VIT.getBannersUrl('12345678abcdef1234567z'), throwsException);
    });
    test('getBanners(cityId)', () async {
      final cityId = '5dfc9fd451f0dc92455bee95';
      final data = (await VIT.getBanners(cityId)).data;
      expect(data, isNotEmpty);
      await saveJson('getBanners(cityId)', data);
    });
    test('getBanners(invalidCityId)', () async {
      expect(() => VIT.getBanners('12345678abcdef1234567z'), throwsException);
    });

    test('getOffersUrl(cityId)', () async {
      final cityId = '5dfc9fd451f0dc92455bee95';
      final data = VIT.getOffersUrl(cityId);
      expect(data, isNotEmpty);
      await saveJson('getOffersUrl(cityId)', data);
    });
    test('getOffersUrl(invalidCityId)', () async {
      expect(() => VIT.getOffersUrl('12345678abcdef1234567z'), throwsException);
    });
    test('getOffers(cityId)', () async {
      final cityId = '5dfc9fd451f0dc92455bee95';
      final data = (await VIT.getOffers(cityId)).data;
      expect(data, isNotEmpty);
      await saveJson('getOffers(cityId)', data);
    });
    test('getOffers(invalidCityId)', () async {
      expect(() => VIT.getOffers('12345678abcdef1234567z'), throwsException);
    });

    test('getSubscriptions(cityId)', () async {
      final cityId = '5dfc9fd451f0dc92455bee95';
      final data = (await VIT.getSubscriptions(cityId)).data;
      expect(data, isNotEmpty);
      await saveJson('getSubscriptions(cityId)', data);
    });
    test('getSubscriptions(invalidCityId)', () async {
      expect(() => VIT.getSubscriptions('12345678abcdef1234567z'),
          throwsException);
    });

    test('getCatalog(cityId)', () async {
      final cityId = '5dfc9fd451f0dc92455bee95';
      final data = (await VIT.getCatalog(cityId)).data;
      expect(data, isNotEmpty);
      await saveJson('getCatalog(cityId)', data);
    });
    test('getCatalog(invalidCityId)', () async {
      expect(() => VIT.getCatalog('12345678abcdef1234567z'), throwsException);
    });

    test('getProducts(cityId)', () async {
      final cityId = '5dfc9fd451f0dc92455bee95';
      final data = (await VIT.getProducts(cityId)).data;
      expect(data, isNotEmpty);
      await saveJson('getProducts(cityId)', data);
    });
    test('getProducts(invalidCityId)', () async {
      expect(() => VIT.getProducts('12345678abcdef1234567z'), throwsException);
    });

    test('getPricesUrl(cityId)', () async {
      final cityId = '5dfc9fd451f0dc92455bee95';
      final data = VIT.getPricesUrl(cityId);
      expect(data, isNotEmpty);
      await saveJson('getPricesUrl(cityId)', data);
    });
    test('getPricesUrl(invalidCityId)', () async {
      expect(() => VIT.getPricesUrl('12345678abcdef1234567z'), throwsException);
    });
    test('getPrices(cityId)', () async {
      final cityId = '5dfc9fd451f0dc92455bee95';
      final data = (await VIT.getPrices(cityId)).data;
      expect(data, isNotEmpty);
      await saveJson('getPrices(cityId)', data);
    });
    test('getPrices(invalidCityId)', () async {
      expect(() => VIT.getPrices('12345678abcdef1234567z'), throwsException);
    });

    test('getAdventConfig(cityId)', () async {
      final cityId = '5dfc9fd451f0dc92455bee95';
      final data = (await VIT.getAdventConfig(cityId)).data;
      expect(data, isNotEmpty);
      await saveJson('getAdventConfig(cityId)', data);
    });
    test('getAdventConfig(invalidCityId)', () async {
      expect(
          () => VIT.getAdventConfig('12345678abcdef1234567z'), throwsException);
    });

    test('getBigfestConfig(cityId)', () async {
      final cityId = '5dfc9fd451f0dc92455bee95';
      final data = (await VIT.getBigfestConfig(cityId)).data;
      expect(data, isNotEmpty);
      await saveJson('getBigfestConfig(cityId)', data);
    });
    test('getBigfestConfig(invalidCityId)', () async {
      expect(() => VIT.getBigfestConfig('12345678abcdef1234567z'),
          throwsException);
    });

    test('getCharityConfig(cityId)', () async {
      final cityId = '5dfc9fd451f0dc92455bee95';
      final data = (await VIT.getCharityConfig(cityId)).data;
      expect(data, isNotEmpty);
      await saveJson('getCharityConfig(cityId)', data);
    });
    test('getCharityConfig(invalidCityId)', () async {
      expect(() => VIT.getCharityConfig('12345678abcdef1234567z'),
          throwsException);
    });

    test('getDeliveryConfig(cityId)', () async {
      final cityId = '5dfc9fd451f0dc92455bee95';
      final data = (await VIT.getDeliveryConfig(cityId)).data;
      expect(data, isNotEmpty);
      await saveJson('getDeliveryConfig(cityId)', data);
    });
    test('getDeliveryConfig(invalidCityId)', () async {
      expect(() => VIT.getDeliveryConfig('12345678abcdef1234567z'),
          throwsException);
    });

    test('getOrderConfig(cityId)', () async {
      final cityId = '5dfc9fd451f0dc92455bee95';
      final data = (await VIT.getOrderConfig(cityId)).data;
      expect(data, isNotEmpty);
      await saveJson('getOrderConfig(cityId)', data);
    });
    test('getOrderConfig(invalidCityId)', () async {
      expect(
          () => VIT.getOrderConfig('12345678abcdef1234567z'), throwsException);
    });

    test('getMonopolyStickers(cityId)', () async {
      final cityId = '5dfc9fd451f0dc92455bee95';
      final data = (await VIT.getMonopolyStickers(cityId)).data;
      expect(data, isNotEmpty);
      await saveJson('getMonopolyStickers(cityId)', data);
    });
    test('getMonopolyStickers(invalidCityId)', () async {
      expect(() => VIT.getMonopolyStickers('12345678abcdef1234567z'),
          throwsException);
    });
  });
}

import 'dart:convert';
import 'dart:io';

import 'package:eitherx/eitherx.dart';
import 'package:example/core/failure.dart';
import 'package:example/core/network.dart';
import 'package:example/core/safe_request_handler.dart';
import 'package:example/settings/data/data-source/settings_local_data_source.dart';
import 'package:example/settings/data/data-source/settings_local_data_source_impl.dart';
import 'package:example/settings/data/repository/settings_remote_data_source_repository_impl.dart';
import 'package:example/settings/domain/repository/settings_remote_data_source_repository.dart';
import 'package:example/settings/models/base_response.dart';
import 'package:example/settings/models/product_model.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:example/settings/settings_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_local_data_source_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SharedPreferences>(),
])
void main() {
  late SharedPreferences sharedPreferences;
  late Failure failure;
  late SettingsLocalDataSource settingsLocalDataSource;
  late List<ProductModel> productModels;
  late SettingsModel settingsModels;
  setUp(() {
    sharedPreferences = MockSharedPreferences();
    failure = Failure(999, "Cache failure");
    settingsLocalDataSource = SettingsLocalDataSourceImpl(sharedPreferences);

    productModels = List.generate(
      2,
      (index) => ProductModel.fromJson(fromJson('expected_product_model')),
    );

    settingsModels =
        SettingsModel.fromJson(fromJson('expected_settings_model'));
  });
  saveProduct() => dataSource.saveProduct(
        productId: "productId",
        type: "type",
      );
  getSavedProducts() => dataSource.getSavedProducts(
        page: 2,
        limit: 2,
      );

  cacheSavedProducts() =>
      settingsLocalDataSource.cacheSavedProducts(data: productModels);

  getCacheSavedProducts() => settingsLocalDataSource.getCacheSavedProducts();

  cacheSettings() =>
      settingsLocalDataSource.cacheSettings(data: settingsModels);

  getCacheSettings() => settingsLocalDataSource.getCacheSettings();

  group('SettingsRemoteDataSourceRepository Repository', () {
    ///[saveProduct Success Test]
    test('saveProduct Success', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
      when(saveProduct())
          .thenAnswer((realInvocation) async => saveProductResponse);
      final res = await repository.saveProduct(
        productId: "productId",
        type: "type",
      );
      expect(res.rightOrNull(), saveProductResponse);
      verify(networkInfo.isConnected);
      verify(saveProduct());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });

    ///[saveProduct Failure Test]
    test('saveProduct Failure', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
      when(saveProduct())
          .thenAnswer((realInvocation) async => saveProductResponse);
      final res = await repository.saveProduct(
        productId: "productId",
        type: "type",
      );
      expect(res.leftOrNull(), isA<Failure>());
      verify(networkInfo.isConnected);
      verify(saveProduct());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });

    ///[getSavedProducts Success Test]
    test('getSavedProducts Success', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
      when(getSavedProducts())
          .thenAnswer((realInvocation) async => getSavedProductsResponse);
      final res = await repository.getSavedProducts(
        page: 2,
        limit: 2,
      );
      expect(res.rightOrNull(), getSavedProductsResponse);
      verify(networkInfo.isConnected);
      verify(getSavedProducts());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });

    ///[getSavedProducts Failure Test]
    test('getSavedProducts Failure', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
      when(getSavedProducts())
          .thenAnswer((realInvocation) async => getSavedProductsResponse);
      final res = await repository.getSavedProducts(
        page: 2,
        limit: 2,
      );
      expect(res.leftOrNull(), isA<Failure>());
      verify(networkInfo.isConnected);
      verify(getSavedProducts());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });

    ///[cacheSavedProducts Success]
    test('cacheSavedProducts', () async {
      when(cacheSavedProducts())
          .thenAnswer((realInvocation) async => const Right(unit));
      final res = await repository.cacheSavedProducts(data: productModels);
      expect(res.rightOrNull(), unit);
      verify(cacheSavedProducts());
      verifyNoMoreInteractions(settingsLocalDataSource);
    });

    ///[cacheSavedProducts Failure]
    test('cacheSavedProducts', () async {
      when(cacheSavedProducts())
          .thenAnswer((realInvocation) async => Left(failure));
      final res = await repository.cacheSavedProducts(data: productModels);
      expect(res.leftOrNull(), isA<Failure>());
      verify(cacheSavedProducts());
      verifyNoMoreInteractions(settingsLocalDataSource);
    });

    ///[getCacheSavedProducts Success]
    test('getCacheSavedProducts', () async {
      when(getCacheSavedProducts())
          .thenAnswer((realInvocation) => Right(productModels));

      final res = repository.getCacheSavedProducts();
      expect(res.rightOrNull(), isA<List<ProductModel>>());
      verify(getCacheSavedProducts());
      verifyNoMoreInteractions(settingsLocalDataSource);
    });

    ///[getCacheSavedProducts Failure]
    test('getCacheSavedProducts', () async {
      when(getCacheSavedProducts())
          .thenAnswer((realInvocation) => Left(failure));

      final res = repository.getCacheSavedProducts();
      expect(res.leftOrNull(), isA<Failure>());
      verify(getCacheSavedProducts());
      verifyNoMoreInteractions(settingsLocalDataSource);
    });

    ///[getSettings Success Test]
    test('getSettings Success', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
      when(getSettings())
          .thenAnswer((realInvocation) async => getSettingsResponse);
      final res = await repository.getSettings();
      expect(res.rightOrNull(), getSettingsResponse);
      verify(networkInfo.isConnected);
      verify(getSettings());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });

    ///[getSettings Failure Test]
    test('getSettings Failure', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
      when(getSettings())
          .thenAnswer((realInvocation) async => getSettingsResponse);
      final res = await repository.getSettings();
      expect(res.leftOrNull(), isA<Failure>());
      verify(networkInfo.isConnected);
      verify(getSettings());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });

    ///[cacheSettings Success]
    test('cacheSettings', () async {
      when(cacheSettings())
          .thenAnswer((realInvocation) async => const Right(unit));
      final res = await repository.cacheSettings(data: settingsModels);
      expect(res.rightOrNull(), unit);
      verify(cacheSettings());
      verifyNoMoreInteractions(settingsLocalDataSource);
    });

    ///[cacheSettings Failure]
    test('cacheSettings', () async {
      when(cacheSettings()).thenAnswer((realInvocation) async => Left(failure));
      final res = await repository.cacheSettings(data: settingsModels);
      expect(res.leftOrNull(), isA<Failure>());
      verify(cacheSettings());
      verifyNoMoreInteractions(settingsLocalDataSource);
    });

    ///[getCacheSettings Success]
    test('getCacheSettings', () async {
      when(getCacheSettings())
          .thenAnswer((realInvocation) => Right(settingsModels));

      final res = repository.getCacheSettings();
      expect(res.rightOrNull(), isA<SettingsModel>());
      verify(getCacheSettings());
      verifyNoMoreInteractions(settingsLocalDataSource);
    });

    ///[getCacheSettings Failure]
    test('getCacheSettings', () async {
      when(getCacheSettings()).thenAnswer((realInvocation) => Left(failure));

      final res = repository.getCacheSettings();
      expect(res.leftOrNull(), isA<Failure>());
      verify(getCacheSettings());
      verifyNoMoreInteractions(settingsLocalDataSource);
    });

    ///[getApp Success Test]
    test('getApp Success', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
      when(getApp()).thenAnswer((realInvocation) async => getAppResponse);
      final res = await repository.getApp(
        page: 2,
        limit: 2,
      );
      expect(res.rightOrNull(), getAppResponse);
      verify(networkInfo.isConnected);
      verify(getApp());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });

    ///[getApp Failure Test]
    test('getApp Failure', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
      when(getApp()).thenAnswer((realInvocation) async => getAppResponse);
      final res = await repository.getApp(
        page: 2,
        limit: 2,
      );
      expect(res.leftOrNull(), isA<Failure>());
      verify(networkInfo.isConnected);
      verify(getApp());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });

    ///[getAA Success Test]
    test('getAA Success', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
      when(getAA()).thenAnswer((realInvocation) async => getAAResponse);
      final res = await repository.getAA();
      expect(res.rightOrNull(), getAAResponse);
      verify(networkInfo.isConnected);
      verify(getAA());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });

    ///[getAA Failure Test]
    test('getAA Failure', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
      when(getAA()).thenAnswer((realInvocation) async => getAAResponse);
      final res = await repository.getAA();
      expect(res.leftOrNull(), isA<Failure>());
      verify(networkInfo.isConnected);
      verify(getAA());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });
  });
}

///[FromJson]
Map<String, dynamic> fromJson(String path) {
  return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}
import 'package:groceryhelper/infrastructure/services/locator.dart';
import '../database/app_database.dart';
import '../datasources/datasource_factory.dart';
import '../datasources/local/local_product_datasource.dart';
import '../datasources/local/local_product_type_datasource.dart';
import '../datasources/local/local_tag_datasource.dart';
import '../datasources/network/network_product_datasource.dart';
import '../datasources/network/network_product_type_datasource.dart';
import '../datasources/network/network_tag_datasource.dart';

class DatabaseDI {
  static void register(AppDatabase appDatabase) {
    // Регистрация базы данных
    locator.registerSingleton<AppDatabase>(appDatabase);

    // Создание фабрики datasource
    locator.registerSingleton<DatasourceFactory>(DatasourceFactory(database: locator<AppDatabase>()));

    // Регистрация local datasource
    locator.registerSingleton<LocalProductDatasource>(locator<DatasourceFactory>().createLocalProductDatasource());

    locator.registerSingleton<LocalProductTypeDatasource>(
      locator<DatasourceFactory>().createLocalProductTypeDatasource(),
    );

    locator.registerSingleton<LocalTagDatasource>(locator<DatasourceFactory>().createLocalTagDatasource());

    // Регистрация network datasource
    locator.registerSingleton<NetworkProductDatasource>(locator<DatasourceFactory>().createNetworkProductDatasource());

    locator.registerSingleton<NetworkProductTypeDatasource>(
      locator<DatasourceFactory>().createNetworkProductTypeDatasource(),
    );

    locator.registerSingleton<NetworkTagDatasource>(locator<DatasourceFactory>().createNetworkTagDatasource());
  }
}

import '../database/app_database.dart';
import 'local/local_product_datasource.dart';
import 'local/local_product_type_datasource.dart';
import 'local/local_tag_datasource.dart';
import 'network/network_product_datasource.dart';
import 'network/network_product_type_datasource.dart';
import 'network/network_tag_datasource.dart';

class DatasourceFactory {
  final AppDatabase _database;

  DatasourceFactory({required AppDatabase database}) : _database = database;

  /// Создает local product datasource
  LocalProductDatasource createLocalProductDatasource() {
    return LocalProductDatasource(productItemsDao: _database.productItemsDao);
  }

  /// Создает network product datasource
  NetworkProductDatasource createNetworkProductDatasource() {
    return NetworkProductDatasource();
  }

  /// Создает local product type datasource
  LocalProductTypeDatasource createLocalProductTypeDatasource() {
    return LocalProductTypeDatasource(database: _database);
  }

  /// Создает network product type datasource
  NetworkProductTypeDatasource createNetworkProductTypeDatasource() {
    return NetworkProductTypeDatasource();
  }

  /// Создает local tag datasource
  LocalTagDatasource createLocalTagDatasource() {
    return LocalTagDatasource(database: _database);
  }

  /// Создает network tag datasource
  NetworkTagDatasource createNetworkTagDatasource() {
    return NetworkTagDatasource();
  }
}

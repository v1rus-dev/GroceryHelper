import '../database/app_database.dart';
import 'interfaces/product_datasource_interface.dart';
import 'interfaces/product_type_datasource_interface.dart';
import 'interfaces/tag_datasource_interface.dart';
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
  ProductDatasourceInterface createLocalProductDatasource() {
    return LocalProductDatasource(database: _database);
  }

  /// Создает network product datasource
  ProductDatasourceInterface createNetworkProductDatasource() {
    return NetworkProductDatasource();
  }

  /// Создает local product type datasource
  ProductTypeDatasourceInterface createLocalProductTypeDatasource() {
    return LocalProductTypeDatasource(database: _database);
  }

  /// Создает network product type datasource
  ProductTypeDatasourceInterface createNetworkProductTypeDatasource() {
    return NetworkProductTypeDatasource();
  }

  /// Создает local tag datasource
  TagDatasourceInterface createLocalTagDatasource() {
    return LocalTagDatasource(database: _database);
  }

  /// Создает network tag datasource
  TagDatasourceInterface createNetworkTagDatasource() {
    return NetworkTagDatasource();
  }
}

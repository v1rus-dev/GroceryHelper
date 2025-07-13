import 'package:groceryhelper/infrastructure/services/locator.dart';
import '../database/app_database.dart';
import '../datasources/datasource_factory.dart';
import '../datasources/interfaces/product_datasource_interface.dart';
import '../datasources/interfaces/product_type_datasource_interface.dart';
import '../datasources/interfaces/tag_datasource_interface.dart';
import '../database/repositories/products_repository_impl.dart';
import '../database/repositories/tags_repository_impl.dart';
import '../services/auth_status_service.dart';
import '../../domain/repositories/products_repository.dart';
import '../../domain/repositories/tags_repository.dart';
import '../../features/category_type/data/repository_impl/product_type_repository_impl.dart';
import '../../features/category_type/domain/repository/product_type_repository.dart';

class DatabaseDI {
  static void register(AppDatabase appDatabase) {
    // Регистрация базы данных
    locator.registerSingleton<AppDatabase>(appDatabase);

    // Регистрация сервиса авторизации
    locator.registerSingleton<AuthStatusService>(FirebaseAuthStatusService());

    // Создание фабрики datasource
    locator.registerSingleton<DatasourceFactory>(DatasourceFactory(database: locator<AppDatabase>()));

    // Регистрация local datasource
    locator.registerSingleton<ProductDatasourceInterface>(
      locator<DatasourceFactory>().createLocalProductDatasource(),
      instanceName: 'local_product',
    );

    locator.registerSingleton<ProductTypeDatasourceInterface>(
      locator<DatasourceFactory>().createLocalProductTypeDatasource(),
      instanceName: 'local_product_type',
    );

    locator.registerSingleton<TagDatasourceInterface>(
      locator<DatasourceFactory>().createLocalTagDatasource(),
      instanceName: 'local_tag',
    );

    // Регистрация network datasource
    locator.registerSingleton<ProductDatasourceInterface>(
      locator<DatasourceFactory>().createNetworkProductDatasource(),
      instanceName: 'network_product',
    );

    locator.registerSingleton<ProductTypeDatasourceInterface>(
      locator<DatasourceFactory>().createNetworkProductTypeDatasource(),
      instanceName: 'network_product_type',
    );

    locator.registerSingleton<TagDatasourceInterface>(
      locator<DatasourceFactory>().createNetworkTagDatasource(),
      instanceName: 'network_tag',
    );

    // Регистрация repository
    locator.registerSingleton<ProductsRepository>(
      ProductsRepositoryImpl(
        localProductDatasource: locator<ProductDatasourceInterface>(instanceName: 'local_product'),
        networkProductDatasource: locator<ProductDatasourceInterface>(instanceName: 'network_product'),
        localProductTypeDatasource: locator<ProductTypeDatasourceInterface>(instanceName: 'local_product_type'),
        networkProductTypeDatasource: locator<ProductTypeDatasourceInterface>(instanceName: 'network_product_type'),
        authStatusService: locator<AuthStatusService>(),
      ),
    );

    locator.registerSingleton<TagsRepository>(
      TagsRepositoryImpl(
        localTagDatasource: locator<TagDatasourceInterface>(instanceName: 'local_tag'),
        networkTagDatasource: locator<TagDatasourceInterface>(instanceName: 'network_tag'),
        authStatusService: locator<AuthStatusService>(),
      ),
    );

    // Регистрация ProductTypeRepository для feature category_type
    locator.registerSingleton<ProductTypeRepository>(
      ProductTypeRepositoryImpl(
        localProductTypeDatasource: locator<ProductTypeDatasourceInterface>(instanceName: 'local_product_type'),
        networkProductTypeDatasource: locator<ProductTypeDatasourceInterface>(instanceName: 'network_product_type'),
        authStatusService: locator<AuthStatusService>(),
      ),
    );
  }
}

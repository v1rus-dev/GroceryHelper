import 'package:dartz/dartz.dart';
import '../../../core/errors/errors.dart';
import '../../../domain/entities/tag.dart';
import '../../../domain/repositories/tags_repository.dart';
import '../../datasources/interfaces/tag_datasource_interface.dart';
import '../../services/auth_status_service.dart';

class TagsRepositoryImpl implements TagsRepository {
  final TagDatasourceInterface _localTagDatasource;
  final TagDatasourceInterface _networkTagDatasource;
  final AuthStatusService _authStatusService;

  TagsRepositoryImpl({
    required TagDatasourceInterface localTagDatasource,
    required TagDatasourceInterface networkTagDatasource,
    required AuthStatusService authStatusService,
  }) : _localTagDatasource = localTagDatasource,
       _networkTagDatasource = networkTagDatasource,
       _authStatusService = authStatusService;

  /// Выбирает правильный datasource на основе статуса авторизации
  TagDatasourceInterface get _tagDatasource {
    return _authStatusService.getCurrentUser() != null ? _networkTagDatasource : _localTagDatasource;
  }

  @override
  Future<Either<AppError, List<Tag>>> getAllTags() async {
    return await _tagDatasource.getAllTags();
  }

  @override
  Future<Either<AppError, Tag?>> getTagById(int id) async {
    return await _tagDatasource.getTagById(id);
  }

  @override
  Future<Either<AppError, Tag>> createTag(Tag tag) async {
    return await _tagDatasource.createTag(tag);
  }

  @override
  Future<Either<AppError, void>> updateTag(Tag tag) async {
    return await _tagDatasource.updateTag(tag);
  }

  @override
  Future<Either<AppError, void>> deleteTag(int id) async {
    return await _tagDatasource.deleteTag(id);
  }
}

import 'package:dartz/dartz.dart';
import '../../../core/errors/errors.dart';
import '../../../domain/entities/tag.dart';
import '../../../domain/repositories/tags_repository.dart';
import '../../datasources/local/local_tag_datasource.dart';
import '../../datasources/network/network_tag_datasource.dart';
import '../../services/auth_status_service.dart';

class TagsRepositoryImpl implements TagsRepository {
  final LocalTagDatasource _localTagDatasource;
  final NetworkTagDatasource _networkTagDatasource;
  final AuthStatusService _authStatusService;

  TagsRepositoryImpl({
    required LocalTagDatasource localTagDatasource,
    required NetworkTagDatasource networkTagDatasource,
    required AuthStatusService authStatusService,
  }) : _localTagDatasource = localTagDatasource,
       _networkTagDatasource = networkTagDatasource,
       _authStatusService = authStatusService;

  @override
  Future<Either<AppError, List<Tag>>> getAllTags() async {
    return await _localTagDatasource.getAllTags();
  }

  @override
  Future<Either<AppError, Tag?>> getTagById(int id) async {
    return await _localTagDatasource.getTagById(id);
  }

  @override
  Future<Either<AppError, Tag>> createTag(Tag tag) async {
    return await _localTagDatasource.createTag(tag);
  }

  @override
  Future<Either<AppError, void>> updateTag(Tag tag) async {
    return await _localTagDatasource.updateTag(tag);
  }

  @override
  Future<Either<AppError, void>> deleteTag(int id) async {
    return await _localTagDatasource.deleteTag(id);
  }
}

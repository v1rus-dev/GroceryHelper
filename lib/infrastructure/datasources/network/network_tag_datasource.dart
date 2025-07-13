import 'package:dartz/dartz.dart';
import '../../../core/errors/errors.dart';
import '../../../domain/entities/tag.dart';
import '../interfaces/tag_datasource_interface.dart';

class NetworkTagDatasource implements TagDatasourceInterface {
  @override
  Future<Either<AppError, List<Tag>>> getAllTags() async {
    // TODO: Реализовать получение тегов из Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  @override
  Future<Either<AppError, Tag?>> getTagById(int id) async {
    // TODO: Реализовать получение тега по ID из Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  @override
  Future<Either<AppError, Tag>> createTag(Tag tag) async {
    // TODO: Реализовать создание тега в Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  @override
  Future<Either<AppError, void>> updateTag(Tag tag) async {
    // TODO: Реализовать обновление тега в Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  @override
  Future<Either<AppError, void>> deleteTag(int id) async {
    // TODO: Реализовать удаление тега из Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }
}

import 'package:dartz/dartz.dart';
import '../../../shared/errors/errors.dart';
import '../../../domain/entities/tag.dart';

class NetworkTagDatasource {
  Future<Either<AppError, List<Tag>>> getAllTags() async {
    // TODO: Реализовать получение тегов из Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  Future<Either<AppError, Tag?>> getTagById(int id) async {
    // TODO: Реализовать получение тега по ID из Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  Future<Either<AppError, Tag>> createTag(Tag tag) async {
    // TODO: Реализовать создание тега в Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  Future<Either<AppError, void>> updateTag(Tag tag) async {
    // TODO: Реализовать обновление тега в Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  Future<Either<AppError, void>> deleteTag(int id) async {
    // TODO: Реализовать удаление тега из Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }
}

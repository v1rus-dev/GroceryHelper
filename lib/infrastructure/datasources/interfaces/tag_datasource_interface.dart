import 'package:dartz/dartz.dart';
import '../../../core/errors/errors.dart';
import '../../../domain/entities/tag.dart';

abstract class TagDatasourceInterface {
  Future<Either<AppError, List<Tag>>> getAllTags();
  Future<Either<AppError, Tag?>> getTagById(int id);
  Future<Either<AppError, Tag>> createTag(Tag tag);
  Future<Either<AppError, void>> updateTag(Tag tag);
  Future<Either<AppError, void>> deleteTag(int id);
}

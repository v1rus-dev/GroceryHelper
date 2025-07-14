import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import '../../../shared/errors/errors.dart';
import '../../../domain/entities/tag.dart';
import '../../database/app_database.dart';

class LocalTagDatasource {
  final AppDatabase _database;

  LocalTagDatasource({required AppDatabase database}) : _database = database;

  Future<Either<AppError, List<Tag>>> getAllTags() async {
    try {
      final tags = await _database.select(_database.tagsTable).get();
      return right(tags.map((tag) => _mapToTag(tag)).toList());
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  Future<Either<AppError, Tag?>> getTagById(int id) async {
    try {
      final tag = await (_database.select(_database.tagsTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

      if (tag == null) return right(null);
      return right(_mapToTag(tag));
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  Future<Either<AppError, Tag>> createTag(Tag tag) async {
    try {
      final companion = TagsTableCompanion.insert(name: tag.name);

      final id = await _database.into(_database.tagsTable).insert(companion);
      return right(tag.copyWith(id: id));
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  Future<Either<AppError, void>> updateTag(Tag tag) async {
    try {
      final companion = TagsTableCompanion(id: Value(tag.id), name: Value(tag.name));

      await (_database.update(_database.tagsTable)..where((tbl) => tbl.id.equals(tag.id))).write(companion);

      return right(null);
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  Future<Either<AppError, void>> deleteTag(int id) async {
    try {
      await (_database.delete(_database.tagsTable)..where((tbl) => tbl.id.equals(id))).go();

      return right(null);
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  Tag _mapToTag(TagsTableData tag) {
    return Tag(id: tag.id, name: tag.name, createdAt: tag.createdAt);
  }
}

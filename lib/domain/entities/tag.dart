import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  final int id;
  final String name;
  final DateTime createdAt;

  const Tag({required this.id, required this.name, required this.createdAt});

  Tag copyWith({int? id, String? name, DateTime? createdAt}) {
    return Tag(id: id ?? this.id, name: name ?? this.name, createdAt: createdAt ?? this.createdAt);
  }

  @override
  List<Object?> get props => [id, name, createdAt];
}

import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String? id;
  final String? name;
  final String? thumbnail;
  final String? description;

  const CategoryEntity({
    this.id,
    this.name,
    this.thumbnail,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, thumbnail, description];
}

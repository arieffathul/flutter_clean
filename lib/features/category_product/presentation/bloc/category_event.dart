part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {}

class CategoryEventAdd extends CategoryEvent {
  final CategoryModels categoryModel;

  CategoryEventAdd({required this.categoryModel});

  @override
  List<Object?> get props => [categoryModel];
}

class CategoryEventEdit extends CategoryEvent {
  final CategoryModels categoryModel;

  CategoryEventEdit({required this.categoryModel});

  @override
  List<Object?> get props => [categoryModel];
}

class CategoryEventDelete extends CategoryEvent {
  final String id;

  CategoryEventDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

class CategoryEventGetAll extends CategoryEvent {
  @override
  List<Object?> get props => [];
}

class CategoryEventGetById extends CategoryEvent {
  final String id;

  CategoryEventGetById({required this.id});
  @override
  List<Object?> get props => [id];
}

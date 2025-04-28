part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {}

class CategoryInitial extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryStateLoading extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryStateError extends CategoryState {
  final String message;

  CategoryStateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class CategoryStateLoadedAll extends CategoryState {
  final List<Category> categorys;

  CategoryStateLoadedAll({required this.categorys});

  @override
  List<Object?> get props => [categorys];
}

class CategoryStateLoaded extends CategoryState {
  final Category category;

  CategoryStateLoaded({required this.category});

  @override
  List<Object?> get props => [category];
}

class CategoryStateSuccess extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

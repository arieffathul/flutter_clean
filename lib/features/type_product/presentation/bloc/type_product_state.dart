part of 'type_product_bloc.dart';

abstract class TypeProductState extends Equatable {}

class TypeProductInitial extends TypeProductState {
  @override
  List<Object> get props => [];
}

class TypeProductStateLoading extends TypeProductState {
  @override
  List<Object> get props => [];
}

class TypeProductStateError extends TypeProductState {
  final String message;

  TypeProductStateError({required this.message});

  @override
  List<Object> get props => [];
}

class TypeProductStateLoadedAll extends TypeProductState {
  final List<TypeProduct> types;

  TypeProductStateLoadedAll({required this.types});

  @override
  List<Object?> get props => [types];
}

class TypeProductStateLoaded extends TypeProductState {
  final TypeProduct type;

  TypeProductStateLoaded({required this.type});

  @override
  List<Object> get props => [type];
}

class TypeProductStateSuccess extends TypeProductState {
  @override
  List<Object> get props => [];
}

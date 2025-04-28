part of 'type_product_bloc.dart';

abstract class TypeEvent extends Equatable {}

class TypeEventAdd extends TypeEvent {
  final TypeModels typeModel;

  TypeEventAdd({required this.typeModel});

  @override
  List<Object?> get props => [typeModel];
}

class TypeEventEdit extends TypeEvent {
  final TypeModels typeModel;

  TypeEventEdit({required this.typeModel});

  @override
  List<Object?> get props => [typeModel];
}

class TypeEventDelete extends TypeEvent {
  final String id;

  TypeEventDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

class TypeEventGetAll extends TypeEvent {
  @override
  List<Object?> get props => [];
}

class TypeEventGetById extends TypeEvent {
  final String id;

  TypeEventGetById({required this.id});
  @override
  List<Object?> get props => [id];
}

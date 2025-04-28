import 'package:clean_flutter/features/type_product/data/models/type_models.dart';
import 'package:clean_flutter/features/type_product/domain/entities/type_product.dart';
import 'package:clean_flutter/features/type_product/domain/usecases/type_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'type_product_event.dart';
part 'type_product_state.dart';

class TypeBloc extends Bloc<TypeEvent, TypeProductState> {
  final TypeUsecasesAddType typeUsecasesAdd;
  final TypeUsecasesEditType typeUsecasesEditType;
  final TypeUsecasesDeleteType typeUsecasesDeleteType;
  final TypeUsecaseGetAll typeUsecasesGetAll;
  final TypeUsecasesGetById typeUsecasesGetById;
  TypeBloc(
      {required this.typeUsecasesAdd,
      required this.typeUsecasesEditType,
      required this.typeUsecasesDeleteType,
      required this.typeUsecasesGetAll,
      required this.typeUsecasesGetById})
      : super(TypeProductInitial()) {
    on<TypeEventAdd>((event, emit) async {
      emit(TypeProductStateLoading());
      final data = await typeUsecasesAdd.execute(type: event.typeModel);
      data.fold(
        (l) {
          emit(TypeProductStateError(message: l.toString()));
        },
        (r) {
          emit(TypeProductStateSuccess());
        },
      );
    });
    on<TypeEventEdit>((event, emit) async {
      emit(TypeProductStateLoading());
      final data = await typeUsecasesEditType.execute(type: event.typeModel);
      data.fold(
        (l) {
          emit(TypeProductStateError(message: l.toString()));
        },
        (r) {
          emit(TypeProductStateSuccess());
        },
      );
    });
    on<TypeEventDelete>((event, emit) async {
      emit(TypeProductStateLoading());
      final data = await typeUsecasesDeleteType.execute(id: event.id);
      data.fold(
        (l) {
          emit(TypeProductStateError(message: l.toString()));
        },
        (r) {
          emit(TypeProductStateSuccess());
        },
      );
    });
    on<TypeEventGetAll>((event, emit) async {
      emit(TypeProductStateLoading());
      final data = await typeUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(TypeProductStateError(message: l.toString()));
        },
        (r) {
          emit(TypeProductStateLoadedAll(types: r));
        },
      );
    });
    on<TypeEventGetById>((event, emit) async {
      emit(TypeProductStateLoading());
      final data = await typeUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(TypeProductStateError(message: l.toString()));
        },
        (r) {
          emit(TypeProductStateLoaded(type: r));
        },
      );
    });
  }
}

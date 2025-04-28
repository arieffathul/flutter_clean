import 'package:clean_flutter/features/category_product/data/models/category_models.dart';
import 'package:clean_flutter/features/category_product/domain/entities/category.dart';
import 'package:clean_flutter/features/category_product/domain/usecases/category_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryUsecasesAddCategory categoryUsecasesAdd;
  final CategoryUsecasesEditCategory categoryUsecasesEditCategory;
  final CategoryUsecasesDeleteCategory categoryUsecasesDeleteCategory;
  final CategoryUsecaseGetAll categoryUsecasesGetAll;
  final CategoryUsecasesGetById categoryUsecasesGetById;
  CategoryBloc(
      {required this.categoryUsecasesAdd,
      required this.categoryUsecasesEditCategory,
      required this.categoryUsecasesDeleteCategory,
      required this.categoryUsecasesGetAll,
      required this.categoryUsecasesGetById})
      : super(CategoryInitial()) {
    on<CategoryEventAdd>((event, emit) async {
      emit(CategoryStateLoading());
      final data =
          await categoryUsecasesAdd.execute(category: event.categoryModel);
      data.fold(
        (l) {
          emit(CategoryStateError(message: l.toString()));
        },
        (r) {
          emit(CategoryStateSuccess());
        },
      );
    });
    on<CategoryEventEdit>((event, emit) async {
      emit(CategoryStateLoading());
      final data = await categoryUsecasesEditCategory.execute(
          category: event.categoryModel);
      data.fold(
        (l) {
          emit(CategoryStateError(message: l.toString()));
        },
        (r) {
          emit(CategoryStateSuccess());
        },
      );
    });
    on<CategoryEventDelete>((event, emit) async {
      emit(CategoryStateLoading());
      final data = await categoryUsecasesDeleteCategory.execute(id: event.id);
      data.fold(
        (l) {
          emit(CategoryStateError(message: l.toString()));
        },
        (r) {
          emit(CategoryStateSuccess());
        },
      );
    });
    on<CategoryEventGetAll>((event, emit) async {
      emit(CategoryStateLoading());
      final data = await categoryUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(CategoryStateError(message: l.toString()));
        },
        (r) {
          emit(CategoryStateLoadedAll(categorys: r));
        },
      );
    });
    on<CategoryEventGetById>((event, emit) async {
      emit(CategoryStateLoading());
      final data = await categoryUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(CategoryStateError(message: l.toString()));
        },
        (r) {
          emit(CategoryStateLoaded(category: r));
        },
      );
    });
  }
}

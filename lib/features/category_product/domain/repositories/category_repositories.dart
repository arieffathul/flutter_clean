import 'package:clean_flutter/features/category_product/data/models/category_models.dart';
import 'package:clean_flutter/features/category_product/domain/entities/category.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepositories {
  //future tipe data bisa banyak
  Future<Either<Exception, List<Category>>> getAllCategory();
  Future<Either<Exception, Category>> getCategoryById({required String id});
  Future<Either<Exception, void>> addCategory(
      {required CategoryModels category});
  Future<Either<Exception, void>> editCategory(
      {required CategoryModels category});
  Future<Either<Exception, void>> deleteCategory({required String id});
}

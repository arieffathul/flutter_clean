import 'package:clean_flutter/features/category_product/data/datasources/category_datasources.dart';
import 'package:clean_flutter/features/category_product/data/models/category_models.dart';
import 'package:clean_flutter/features/category_product/domain/entities/category.dart';
import 'package:clean_flutter/features/category_product/domain/repositories/category_repositories.dart';
import 'package:dartz/dartz.dart';

class CategoryRepoImpl implements CategoryRepositories {
  //menambahkan CategoryRemoteDataSource
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepoImpl({required this.categoryRemoteDataSource});
  @override
  Future<Either<Exception, void>> addCategory(
      {required CategoryModels category}) async {
    try {
      final data =
          await categoryRemoteDataSource.addCategory(category: category);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> deleteCategory({required String id}) async {
    try {
      final data = await categoryRemoteDataSource.deleteCategory(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editCategory(
      {required CategoryModels category}) async {
    try {
      final data =
          await categoryRemoteDataSource.editCategory(category: category);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Category>>> getAllCategory() async {
    try {
      final data = await categoryRemoteDataSource.getAllCategory();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Category>> getCategoryById(
      {required String id}) async {
    try {
      final data = await categoryRemoteDataSource.getCategoryById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
}

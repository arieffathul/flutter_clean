import 'package:clean_flutter/features/category_product/data/models/category_models.dart';
import 'package:clean_flutter/features/category_product/domain/entities/category.dart';
import 'package:clean_flutter/features/category_product/domain/repositories/category_repositories.dart';
import 'package:dartz/dartz.dart';

class CategoryUsecaseGetAll {
  final CategoryRepositories categoryRepositories;

  CategoryUsecaseGetAll({required this.categoryRepositories});

  Future<Either<Exception, List<Category>>> execute() async {
    return await categoryRepositories.getAllCategory();
  }
}

class CategoryUsecasesGetById {
  final CategoryRepositories categoryRepositories;

  CategoryUsecasesGetById({required this.categoryRepositories});

  Future<Either<Exception, Category>> execute({required String id}) async {
    return await categoryRepositories.getCategoryById(id: id);
  }
}

class CategoryUsecasesAddCategory {
  final CategoryRepositories categoryRepositories;

  CategoryUsecasesAddCategory({required this.categoryRepositories});

  Future<Either<Exception, void>> execute(
      {required CategoryModels category}) async {
    return await categoryRepositories.addCategory(category: category);
  }
}

class CategoryUsecasesEditCategory {
  final CategoryRepositories categoryRepositories;

  CategoryUsecasesEditCategory({required this.categoryRepositories});

  Future<Either<Exception, void>> execute(
      {required CategoryModels category}) async {
    return await categoryRepositories.editCategory(category: category);
  }
}

class CategoryUsecasesDeleteCategory {
  final CategoryRepositories categoryRepositories;

  CategoryUsecasesDeleteCategory({required this.categoryRepositories});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await categoryRepositories.deleteCategory(id: id);
  }
}

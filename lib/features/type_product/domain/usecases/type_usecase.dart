import 'package:clean_flutter/features/type_product/data/models/type_models.dart';
import 'package:clean_flutter/features/type_product/domain/entities/type_product.dart';
import 'package:clean_flutter/features/type_product/domain/repositories/type_repository.dart';
import 'package:dartz/dartz.dart';

class TypeUsecaseGetAll {
  final TypeRepository typeRepositories;

  TypeUsecaseGetAll({required this.typeRepositories});

  Future<Either<Exception, List<TypeProduct>>> execute() async {
    return await typeRepositories.getAllType();
  }
}

class TypeUsecasesGetById {
  final TypeRepository typeRepositories;

  TypeUsecasesGetById({required this.typeRepositories});

  Future<Either<Exception, TypeProduct>> execute({required String id}) async {
    return await typeRepositories.getTypebyId(id: id);
  }
}

class TypeUsecasesAddType {
  final TypeRepository typeRepositories;

  TypeUsecasesAddType({required this.typeRepositories});

  Future<Either<Exception, void>> execute({required TypeModels type}) async {
    return await typeRepositories.addType(type: type);
  }
}

class TypeUsecasesEditType {
  final TypeRepository typeRepositories;

  TypeUsecasesEditType({required this.typeRepositories});

  Future<Either<Exception, void>> execute({required TypeModels type}) async {
    return await typeRepositories.editType(type: type);
  }
}

class TypeUsecasesDeleteType {
  final TypeRepository typeRepositories;

  TypeUsecasesDeleteType({required this.typeRepositories});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await typeRepositories.deleteType(id: id);
  }
}

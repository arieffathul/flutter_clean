import 'package:clean_flutter/features/type_product/data/models/type_models.dart';
import 'package:clean_flutter/features/type_product/domain/entities/type_product.dart';
import 'package:dartz/dartz.dart';

abstract class TypeRepository {
  Future<Either<Exception, List<TypeProduct>>> getAllType();
  Future<Either<Exception, TypeProduct>> getTypebyId({required String id});
  Future<Either<Exception, void>> addType({required TypeModels type});
  Future<Either<Exception, void>> editType({required TypeModels type});
  Future<Either<Exception, void>> deleteType({required String id});
}

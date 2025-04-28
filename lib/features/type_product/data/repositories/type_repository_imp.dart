import 'package:clean_flutter/features/type_product/data/datasources/type_datasources.dart';
import 'package:clean_flutter/features/type_product/data/models/type_models.dart';
import 'package:clean_flutter/features/type_product/domain/entities/type_product.dart';
import 'package:clean_flutter/features/type_product/domain/repositories/type_repository.dart';
import 'package:dartz/dartz.dart';

class TypeRepoImpl implements TypeRepository {
  //menambahkan TypeRemoteDataSource
  final TypeRemoteDataSource typeRemoteDataSource;

  TypeRepoImpl({required this.typeRemoteDataSource});
  @override
  Future<Either<Exception, void>> addType({required TypeModels type}) async {
    try {
      final data = await typeRemoteDataSource.addType(type: type);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> deleteType({required String id}) async {
    try {
      final data = await typeRemoteDataSource.deleteType(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editType({required TypeModels type}) async {
    try {
      final data = await typeRemoteDataSource.editType(type: type);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<TypeProduct>>> getAllType() async {
    try {
      final data = await typeRemoteDataSource.getAllType();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, TypeProduct>> getTypebyId(
      {required String id}) async {
    try {
      final data = await typeRemoteDataSource.getTypeById(id: id);
      return Right(data);
    } catch (e) {
      throw left(Exception(e));
    }
  }
}

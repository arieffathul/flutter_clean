import 'package:clean_flutter/features/suplier/data/models/suplier_model.dart';
import 'package:clean_flutter/features/suplier/domain/entities/suplier.dart';
import 'package:dartz/dartz.dart';

abstract class SuplierRepository {
  Future<Either<Exception, List<Suplier>>> getAllSuplier();
  Future<Either<Exception, Suplier>> getSuplierById({required String id});
  Future<Either<Exception, void>> addSuplier({required SuplierModel suplier});
  Future<Either<Exception, void>> editSuplier({required SuplierModel suplier});
  Future<Either<Exception, void>> deleteSuplier({required String id});
}

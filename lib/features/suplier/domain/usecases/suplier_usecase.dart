import 'package:clean_flutter/features/suplier/data/models/suplier_model.dart';
import 'package:clean_flutter/features/suplier/domain/entities/suplier.dart';
import 'package:clean_flutter/features/suplier/domain/repositories/suplier_repository.dart';
import 'package:dartz/dartz.dart';

class SuplierUsecaseGetAll {
  final SuplierRepository suplierRepository;

  SuplierUsecaseGetAll({required this.suplierRepository});

  Future<Either<Exception, List<Suplier>>> execute() async {
    return await suplierRepository.getAllSuplier();
  }
}

class SuplierUsecasesGetById {
  final SuplierRepository suplierRepository;

  SuplierUsecasesGetById({required this.suplierRepository});

  Future<Either<Exception, Suplier>> execute({required String id}) async {
    return await suplierRepository.getSuplierById(id: id);
  }
}

class SuplierUsecasesAddSuplier {
  final SuplierRepository suplierRepository;

  SuplierUsecasesAddSuplier({required this.suplierRepository});

  Future<Either<Exception, void>> execute(
      {required SuplierModel suplier}) async {
    return await suplierRepository.addSuplier(suplier: suplier);
  }
}

class SuplierUsecasesEditSuplier {
  final SuplierRepository suplierRepository;

  SuplierUsecasesEditSuplier({required this.suplierRepository});

  Future<Either<Exception, void>> execute(
      {required SuplierModel suplier}) async {
    return await suplierRepository.editSuplier(suplier: suplier);
  }
}

class SuplierUsecasesDeleteSuplier {
  final SuplierRepository suplierRepository;

  SuplierUsecasesDeleteSuplier({required this.suplierRepository});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await suplierRepository.deleteSuplier(id: id);
  }
}

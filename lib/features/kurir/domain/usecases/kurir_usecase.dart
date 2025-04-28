import 'package:clean_flutter/features/kurir/data/models/kurir_model.dart';
import 'package:clean_flutter/features/kurir/domain/entities/kurir.dart';
import 'package:clean_flutter/features/kurir/domain/repositories/kurir_repository.dart';
import 'package:dartz/dartz.dart';

class KurirUsecaseGetAll {
  final KurirRepository kurirRepository;

  KurirUsecaseGetAll({required this.kurirRepository});

  Future<Either<Exception, List<Kurir>>> execute() async {
    return await kurirRepository.getAllKurir();
  }
}

class KurirUsecasesGetById {
  final KurirRepository kurirRepository;

  KurirUsecasesGetById({required this.kurirRepository});

  Future<Either<Exception, Kurir>> execute({required String id}) async {
    return await kurirRepository.getKurirById(id: id);
  }
}

class KurirUsecasesAddKurir {
  final KurirRepository kurirRepository;

  KurirUsecasesAddKurir({required this.kurirRepository});

  Future<Either<Exception, void>> execute({required KurirModel kurir}) async {
    return await kurirRepository.addKurir(kurir: kurir);
  }
}

class KurirUsecasesEditKurir {
  final KurirRepository kurirRepository;

  KurirUsecasesEditKurir({required this.kurirRepository});

  Future<Either<Exception, void>> execute({required KurirModel kurir}) async {
    return await kurirRepository.editKurir(kurir: kurir);
  }
}

class KurirUsecasesDeleteKurir {
  final KurirRepository kurirRepository;

  KurirUsecasesDeleteKurir({required this.kurirRepository});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await kurirRepository.deleteKurir(id: id);
  }
}

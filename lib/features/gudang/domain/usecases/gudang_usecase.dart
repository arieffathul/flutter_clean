import 'package:clean_flutter/features/gudang/data/models/gudang_model.dart';
import 'package:clean_flutter/features/gudang/domain/entities/gudang.dart';
import 'package:clean_flutter/features/gudang/domain/repositories/gudang_repository.dart';
import 'package:dartz/dartz.dart';

class GudangUsecaseGetAll {
  final GudangRepository gudangRepository;

  GudangUsecaseGetAll({required this.gudangRepository});

  Future<Either<Exception, List<Gudang>>> execute() async {
    return await gudangRepository.getAllGudang();
  }
}

class GudangUsecasesGetById {
  final GudangRepository gudangRepository;

  GudangUsecasesGetById({required this.gudangRepository});

  Future<Either<Exception, Gudang>> execute({required String id}) async {
    return await gudangRepository.getGudangById(id: id);
  }
}

class GudangUsecasesAddGudang {
  final GudangRepository gudangRepository;

  GudangUsecasesAddGudang({required this.gudangRepository});

  Future<Either<Exception, void>> execute({required GudangModel gudang}) async {
    return await gudangRepository.addGudang(gudang: gudang);
  }
}

class GudangUsecasesEditGudang {
  final GudangRepository gudangRepository;

  GudangUsecasesEditGudang({required this.gudangRepository});

  Future<Either<Exception, void>> execute({required GudangModel gudang}) async {
    return await gudangRepository.editGudang(gudang: gudang);
  }
}

class GudangUsecasesDeleteGudang {
  final GudangRepository gudangRepository;

  GudangUsecasesDeleteGudang({required this.gudangRepository});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await gudangRepository.deleteGudang(id: id);
  }
}

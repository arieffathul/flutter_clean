import 'package:dartz/dartz.dart';

// Mencetak Template
abstract class UseCase<Type, Params> {
  Future<Either<Exception, Type>> call(Params params);
}

class NoParams {}

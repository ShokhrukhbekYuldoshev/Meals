import 'package:dartz/dartz.dart';
import 'package:meals/core/errors/failures.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

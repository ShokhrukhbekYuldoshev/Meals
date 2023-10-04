import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }

  Either<Failure, double> stringToUnsignedDouble(String str) {
    try {
      final doubleValue = double.parse(str);
      if (doubleValue < 0) throw const FormatException();
      return Right(doubleValue);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }

  Either<Failure, String> stringToNonEmptyString(String str) {
    if (str.isNotEmpty) {
      return Right(str);
    } else {
      return Left(InvalidInputFailure());
    }
  }
}

import 'package:creonit/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type>{
  Future<Either<Failure,Type>>call();
}
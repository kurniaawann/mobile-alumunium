import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/domain/entities/home.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeEntity>> getDataHome();
}

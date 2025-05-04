import 'package:dartz/dartz.dart';
import 'package:mobile_alumunium/exceptions/failures.dart';
import 'package:mobile_alumunium/features/domain/entities/home.dart';
import 'package:mobile_alumunium/features/domain/repositories/home/home_repository.dart';

class HomeUseCase {
  final HomeRepository repository;
  HomeUseCase(this.repository);
  Future<Either<Failure, HomeEntity>> execute() {
    return repository.getDataHome();
  }
}

import 'package:dartz/dartz.dart';
import '../../../core/error/server_failure.dart';

import '../../../domain/entities/home/category_entity.dart';

abstract class CategoriesDataSource {
  Future<Either<ServerFailure, List<Category>?>> getCategories();
}

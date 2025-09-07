import 'package:finances_app/src/core/result/result.dart';
import 'package:finances_app/src/features/categories/category_model.dart';

abstract class CategoryRepository {
  Future<Result<List<CategoryModel>>> findAll();
  Future<Result<List<CategoryModel>>> findByCategoryType(CategoryType type);
  Future<Result<bool>> saveCategory(CategoryModel category);
}

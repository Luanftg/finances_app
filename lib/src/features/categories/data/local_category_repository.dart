import 'dart:convert';
import 'dart:developer';

import 'package:finances_app/src/core/result/result.dart';
import 'package:finances_app/src/features/categories/category_model.dart';
import 'package:finances_app/src/features/categories/data/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalCategoryRepository implements CategoryRepository {
  final String categoryKey = 'category_key';
  @override
  Future<Result<List<CategoryModel>>> findAll() async {
    try {
      final shared = await SharedPreferences.getInstance();
      final categories = await shared.getStringList(categoryKey);
      if (categories != null) {
        final categorieModels = categories
            .map(
              (e) => CategoryModel.fromJson(e),
            )
            .toList();
        return Result.sucess(categorieModels);
      }
      if (categories == null) {
        final List<CategoryModel> _categoriasDespesa = [
          CategoryModel(name: 'Casa', color: Colors.blueAccent),
          CategoryModel(name: 'Animais', color: Colors.green),
          CategoryModel(name: 'Transporte', color: Colors.amber),
          CategoryModel(name: 'Alimentação', color: Colors.red),
          CategoryModel(name: 'Cartão de crédito', color: Colors.deepPurple),
        ];

        final List<CategoryModel> _categoriasReceita = [
          CategoryModel(
              name: 'Salário', type: CategoryType.receita, color: Colors.teal),
          CategoryModel(
              name: 'Aluguel',
              type: CategoryType.receita,
              color: Colors.indigo),
        ];

        final categoryList =
            List<CategoryModel>.from(_categoriasReceita + _categoriasDespesa);
        await shared.setStringList(
            categoryKey,
            categoryList
                .map(
                  (e) => e.toJson(),
                )
                .toList());
        return Result.sucess(categoryList);
      }
      return Result.sucess([]);
    } catch (e) {
      log(e.toString());
      return Result.failure(
        Exception('Erro ao buscar categorias com SharedPreferences'),
      );
    }
  }

  @override
  Future<Result<List<CategoryModel>>> findByCategoryType(
      CategoryType type) async {
    try {
      final result = await findAll();
      if (result is Sucess) {
        final filtered = result.asSucess.value
            .where((element) => element.type == type)
            .toList();
        return Result.sucess(filtered);
      } else if (result is Failure) {
        return Result.failure(result.asFailure.error);
      }
      return Result.sucess([]);
    } catch (e) {
      log(e.toString());
      return Result.failure(
        Exception(
            'Erro ao buscar categorias do tipo: [${type.name}] com SharedPreferences'),
      );
    }
  }

  @override
  Future<Result<bool>> saveCategory(CategoryModel category) async {
    try {
      final result = await findAll();
      if (result is Sucess) {
        final List<CategoryModel> updatedList = List.from(result.asSucess.value)
          ..add(category);
        final shared = await SharedPreferences.getInstance();
        await shared.setStringList(
          categoryKey,
          updatedList
              .map(
                (e) => jsonEncode(e.toJson()),
              )
              .toList(),
        );
        return Result.sucess(true);
      } else if (result is Failure) {
        return Result.failure(result.asFailure.error);
      }
      return Result.sucess(false);
    } catch (e) {
      log(e.toString());
      return Result.failure(
        Exception(
          'Erro ao salvar categorias com SharedPreferences',
        ),
      );
    }
  }
}

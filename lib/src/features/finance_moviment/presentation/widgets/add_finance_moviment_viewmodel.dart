import 'package:finances_app/src/core/command/commands.dart';
import 'package:finances_app/src/core/result/result.dart';
import 'package:finances_app/src/features/categories/category_model.dart';
import 'package:finances_app/src/features/categories/data/category_repository.dart';
import 'package:finances_app/src/features/finance_moviment/data/finance_moviment_repository.dart';
import 'package:finances_app/src/features/finance_moviment/domain/finance_moviment_model.dart';
import 'package:finances_app/src/features/finance_moviment/domain/input_finance_moviment.dart';
import 'package:finances_app/src/features/payment_types/data/payment_types_repository.dart';
import 'package:flutter/material.dart';

class AddFinanceMovimentViewmodel extends ChangeNotifier {
  final CategoryRepository _categoryRepository;
  final FinanceMovimentRepository _financeMovimentService;
  final PaymentTypesRepository _paymentTypesRepository;

  AddFinanceMovimentViewmodel({
    required CategoryRepository localCategoryRepository,
    required FinanceMovimentRepository financeMovimentRepository,
    required PaymentTypesRepository paymentRepository,
  })  : _categoryRepository = localCategoryRepository,
        _financeMovimentService = financeMovimentRepository,
        _paymentTypesRepository = paymentRepository {
    fetchCategoryCommand = Command0(fetchLocalCategories)..execute();
    fetchPaymentTypesCommand = Command0(fetchLocalPaymentTypes)..execute();
    saveFinanceMovimentCommand =
        Command0<FinanceMovimentModel>(saveFinanceMoviment);

    _model = InputFinanceMoviment();
  }

  late final Command0 fetchCategoryCommand;
  late final Command0 fetchPaymentTypesCommand;
  late final Command0 saveFinanceMovimentCommand;

  late InputFinanceMoviment _model;
  InputFinanceMoviment get model => _model;

  List<CategoryModel> _expenseCategories = [];
  List<CategoryModel> get expenseCategories => _expenseCategories;
  List<CategoryModel> _revenueCategories = [];
  List<CategoryModel> get revenueCategories => _revenueCategories;
  List<TipoDePagamento> _paymentTypes = [];
  List<TipoDePagamento> get paymentTypes => _paymentTypes;

  bool _isFormValid() =>
      _model.data != null &&
      _model.value != null &&
      _model.tipoDePagamento?.name != null &&
      _model.categoryModel != null;
  bool _formValid = false;
  bool get isFormValid => _formValid;

  Future<void> changePaymentType(String? value) async {
    if (value == null) return;
    _model = _model.copyWith(tipoDePagamento: TipoDePagamento(name: value));
    _formValid = _isFormValid();
    notifyListeners();
    return;
  }

  Future<void> changeCategory(CategoryModel? value) async {
    _model = _model.copyWith(categoryModel: value);
    _formValid = _isFormValid();
    notifyListeners();
    return;
  }

  Future<void> changeDescription(String value) async {
    _model = _model.copyWith(description: value);
    _formValid = _isFormValid();
    notifyListeners();
    return;
  }

  Future<void> changeValue(String value) async {
    final parsed = value.substring(3).replaceAll('.', '').replaceAll(',', '.');
    _model = _model.copyWith(value: double.tryParse(parsed));
    _formValid = _isFormValid();
    notifyListeners();
    return;
  }

  Future<void> changeDate(DateTime? data) async {
    _model = _model.copyWith(data: data);
    _formValid = _isFormValid();
    notifyListeners();
    return;
  }

  Future<void> changeIsExpense(bool isExpense) async {
    _model = _model.copyWith(isExpense: isExpense);
    _formValid = _isFormValid();
    notifyListeners();
    return;
  }

  Future<void> changeIsMonthFrequency(bool isExpense) async {
    _model = _model.copyWith(isMonthFrequency: isExpense);
    _formValid = _isFormValid();
    notifyListeners();
    return;
  }

  Future<Result<List<CategoryModel>>> fetchLocalCategories() async {
    final resultCategories = await _categoryRepository.findAll();
    _expenseCategories = resultCategories.asSucess.value
        .where((e) => e.type == CategoryType.despesa)
        .toList();
    _revenueCategories = resultCategories.asSucess.value
        .where((e) => e.type == CategoryType.receita)
        .toList();
    notifyListeners();
    switch (resultCategories) {
      case Sucess():
        return Result.sucess(resultCategories.value);
      case Failure():
        return Result.failure(
          Exception('Erro ao buscar categorias'),
        );
    }
    ;
    notifyListeners();
    return Result.sucess([]);
  }

  Future<Result<List<String>>> fetchLocalPaymentTypes() async {
    final resultPayments = await _paymentTypesRepository.findAll();

    notifyListeners();
    switch (resultPayments) {
      case Sucess():
        _paymentTypes = resultPayments.asSucess.value
            .map(
              (e) => TipoDePagamento(name: e),
            )
            .toList();
        return Result.sucess(resultPayments.value);
      case Failure():
        return Result.failure(
          Exception('Erro ao buscar tupos de pagamentos'),
        );
    }
    ;
    notifyListeners();
    return Result.sucess([]);
  }

  Future<Result<FinanceMovimentModel>> saveFinanceMoviment() async {
    if (!_isFormValid())
      return Result.failure(Exception('Modelo inválido. Faltam Campos.'));
    final model = FinanceMovimentModel(
      categoryModel: _model.categoryModel!,
      data: _model.data!,
      description: _model.description,
      tipoDePagamento: _model.tipoDePagamento!,
      value: _model.value!,
      id: FinanceMovimentId(
        value: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
    );
    final result = await _financeMovimentService.save(model);
    notifyListeners();
    return result
        ? Result.sucess(model)
        : Result.failure(Exception('Erro ao salvar Movimentação Financeira'));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

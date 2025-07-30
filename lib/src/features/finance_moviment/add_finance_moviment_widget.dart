import 'dart:developer';

import 'package:finances_app/src/core/extensions/datetime_extension.dart';
import 'package:finances_app/src/features/categories/category_model.dart';
import 'package:finances_app/src/features/finance_moviment/data/local_finance_moviment_service.dart';
import 'package:finances_app/src/features/finance_moviment/domain/finance_moviment_model.dart';
import 'package:finances_app/src/features/finance_moviment/finances_card_widget.dart';
import 'package:finances_app/src/core/widgets/form_field_widget.dart';
import 'package:finances_app/src/core/formatters/real_input_formatter.dart';
import 'package:flutter/material.dart';

class AddFinanceMoviment extends StatefulWidget {
  const AddFinanceMoviment({super.key});

  @override
  State<AddFinanceMoviment> createState() => _AddFinanceMovimentState();
}

class _AddFinanceMovimentState extends State<AddFinanceMoviment> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();
  final ValueNotifier<bool> _isExpense = ValueNotifier(true);
  final ValueNotifier<bool> _isMonthFrequency = ValueNotifier(true);
  final ValueNotifier<Color?> _color = ValueNotifier(Colors.transparent);
  final ValueNotifier<DateTime?> _dateTime = ValueNotifier(null);

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
        name: 'Aluguel', type: CategoryType.receita, color: Colors.indigo),
  ];

  final List<String> paymentTypes = ['Pix', 'Dinheiro', 'Crédito', 'Debito'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ValueListenableBuilder(
                  valueListenable: _color,
                  builder: (context, value, child) {
                    return FinancesCardWidget(
                      isExpense: _isExpense,
                      cardColor: _color,
                      color: value,
                      dataController: _dataController,
                      categoryController: _categoryController,
                      payment: _paymentController.text,
                      valueController: _valueController,
                      descriptionController: _descriptionController,
                    );
                  }),
            ),
            Expanded(
              child: Form(
                key: _key,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      FormFieldWidget(
                        label: 'Natureza',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Receita'),
                            ValueListenableBuilder(
                              valueListenable: _isExpense,
                              builder: (context, value, _) => Switch(
                                  value: value,
                                  onChanged: (val) {
                                    _categoryController.value =
                                        TextEditingValue.empty;
                                    _color.value = Colors.grey;
                                    _isExpense.value = val;
                                  }),
                            ),
                            const Text('Despesa'),
                          ],
                        ),
                      ),
                      FormFieldWidget(
                        label: 'Frequência',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Mensal'),
                            ValueListenableBuilder(
                              valueListenable: _isMonthFrequency,
                              builder: (context, value, _) => Switch(
                                value: value,
                                onChanged: (val) =>
                                    _isMonthFrequency.value = val,
                              ),
                            ),
                            const Text('Pontual'),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final now = DateTime.now();
                                final DateTime? dateTime = await showDatePicker(
                                  context: context,
                                  firstDate: now.subtract(Duration(days: 365)),
                                  lastDate: now.add(Duration(days: 365)),
                                  initialDate: now,
                                );
                                if (dateTime != null) {
                                  _dateTime.value = dateTime;
                                  _dataController.text = dateTime.onlyDate;
                                }
                              },
                              child: FormFieldWidget(
                                  label: 'Data',
                                  child: ValueListenableBuilder(
                                      valueListenable: _dataController,
                                      builder: (context, value, child) {
                                        return SizedBox(
                                          width: double.infinity,
                                          height: kTextTabBarHeight,
                                          child: Center(
                                            child: Text(
                                              _dataController.text.isEmpty
                                                  ? 'Selecionar data'
                                                  : _dataController.text,
                                            ),
                                          ),
                                        );
                                      })),
                            ),
                          ),
                          Expanded(
                            child: FormFieldWidget(
                              label: 'Valor',
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                controller: _valueController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [RealInputFormatter()],
                              ),
                            ),
                          ),
                        ],
                      ),
                      FormFieldWidget(
                        label: 'Descrição',
                        child: TextFormField(
                          decoration: InputDecoration(border: InputBorder.none),
                          controller: _descriptionController,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ValueListenableBuilder(
                          valueListenable: _isExpense,
                          builder: (context, value, child) {
                            return FormFieldWidget(
                              label:
                                  'Selecione uma categoria de ${_isExpense.value ? 'Despesa' : 'Receita'}',
                              child: DropdownMenu<CategoryModel>(
                                onSelected: (value) =>
                                    _color.value = value?.color,
                                width: double.infinity,
                                dropdownMenuEntries: value
                                    ? _categoriasDespesa
                                        .map(
                                          (e) => DropdownMenuEntry(
                                              value: e,
                                              label: e.name,
                                              leadingIcon: Container(
                                                width: 12,
                                                height: 12,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: e.color,
                                                ),
                                              ),
                                              labelWidget: Text(e.name)),
                                        )
                                        .toList()
                                    : _categoriasReceita
                                        .map(
                                          (e) => DropdownMenuEntry(
                                            value: e,
                                            label: e.name,
                                            leadingIcon: Container(
                                              width: 12,
                                              height: 12,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: e.color,
                                              ),
                                            ),
                                            labelWidget: Text(e.name),
                                          ),
                                        )
                                        .toList(),
                                controller: _categoryController,
                              ),
                            );
                          }),
                      ValueListenableBuilder(
                          valueListenable: _isExpense,
                          builder: (context, value, child) {
                            return FormFieldWidget(
                              label:
                                  'Selecione um de Tipo de ${_isExpense.value ? 'pagamento' : 'recebimento'}',
                              child: DropdownMenu<String>(
                                onSelected: (value) =>
                                    _paymentController.text = value ?? '',
                                width: double.infinity,
                                dropdownMenuEntries: paymentTypes
                                    .map(
                                      (e) => DropdownMenuEntry<String>(
                                        value: e,
                                        label: e,
                                        leadingIcon: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        labelWidget: Text(e),
                                      ),
                                    )
                                    .toList(),
                                controller: _paymentController,
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  BeveledRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(4),
                  ),
                ),
              ),
              onPressed: () {
                if (_dateTime.value != null &&
                    _valueController.text.isNotEmpty &&
                    _paymentController.text.isNotEmpty &&
                    _categoryController.text.isNotEmpty) {
                  log('Data: ${_dataController.text}\nValor: ${_valueController.text}\nDescrição: ${_descriptionController.text}\nCategoria: ${_categoryController.text}\nÉ Despesa: ${_isExpense.value}\nÉ Mensal: ${_isMonthFrequency.value}');
                  final FinanceMovimentModel model = FinanceMovimentModel(
                    id: FinanceMovimentId(
                        value:
                            DateTime.now().millisecondsSinceEpoch.toString()),
                    categoryModel:
                        CategoryModel(name: _categoryController.text),
                    value: double.tryParse(_valueController.text) ?? 00,
                    tipoDePagamento:
                        TipoDePagamento(name: _paymentController.text),
                    data: _dateTime.value ?? DateTime.now(),
                    description: _descriptionController.text,
                  );

                  LocalFinanceMovimentService().save(model);
                }
              },
              child: const Text('Adicionar'),
            ),
          ),
        ),
      ),
    );
  }
}

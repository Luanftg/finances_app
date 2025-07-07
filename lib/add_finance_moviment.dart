import 'dart:developer';

import 'package:finances_app/CAtegory_model.dart';
import 'package:finances_app/datetime_extension.dart';
import 'package:finances_app/form_field_widget.dart';
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
  final ValueNotifier<Color?> _color = ValueNotifier(Colors.grey);

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
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: _color.value ?? Colors.grey,
                            blurRadius: 5,
                            blurStyle: BlurStyle.outer,
                            spreadRadius: 2,
                          )
                        ],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: _isExpense,
                                  builder: (context, value, child) {
                                    return Text(
                                      value ? 'Despesa' : 'Receita',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: 120,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    controller: _dataController,
                                    readOnly: true,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                ValueListenableBuilder(
                                    valueListenable: _color,
                                    builder: (context, value, child) {
                                      return Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: _color.value,
                                        ),
                                      );
                                    }),
                                Flexible(
                                  child: ListTile(
                                    title: TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                      controller: _categoryController,
                                      readOnly: true,
                                    ),
                                    subtitle: Text(_paymentController.text),
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    controller: _valueController,
                                    readOnly: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                      InkWell(
                        onTap: () async {
                          final now = DateTime.now();
                          final DateTime? dateTime = await showDatePicker(
                            context: context,
                            firstDate: now.subtract(Duration(days: 365)),
                            lastDate: now.add(Duration(days: 365)),
                            initialDate: now,
                          );
                          if (dateTime != null) {
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
                      FormFieldWidget(
                        label: 'Valor',
                        child: TextFormField(
                          decoration: InputDecoration(border: InputBorder.none),
                          controller: _valueController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      FormFieldWidget(
                        label: 'Descrição',
                        child: TextFormField(
                          decoration: InputDecoration(border: InputBorder.none),
                          controller: _descriptionController,
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
                                dropdownMenuEntries:
                                    ['Pix', 'Dinheiro', 'Crédito', 'Debito']
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                if (_key.currentState?.validate() ?? false) {
                  log('Data: ${_dataController.text}\nValor: ${_valueController.text}\nDescrição: ${_descriptionController.text}\nCategoria: ${_categoryController.text}\nÉ Despesa: ${_isExpense.value}\nÉ Mensal: ${_isMonthFrequency.value}');
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

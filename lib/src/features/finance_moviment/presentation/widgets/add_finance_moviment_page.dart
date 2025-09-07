import 'package:finances_app/src/core/extensions/datetime_extension.dart';
import 'package:finances_app/src/core/mixins/dialog_message_mixin.dart';
import 'package:finances_app/src/features/categories/category_model.dart';
import 'package:finances_app/src/features/finance_moviment/presentation/widgets/add_finance_moviment_viewmodel.dart';
import 'package:finances_app/src/features/finance_moviment/presentation/widgets/finances_card_widget.dart';
import 'package:finances_app/src/core/widgets/form_field_widget.dart';
import 'package:finances_app/src/core/formatters/real_input_formatter.dart';
import 'package:flutter/material.dart';

class AddFinanceMovimentPage extends StatefulWidget {
  const AddFinanceMovimentPage({super.key, required this.viewmodel});

  final AddFinanceMovimentViewmodel viewmodel;

  @override
  State<AddFinanceMovimentPage> createState() => _AddFinanceMovimentPageState();
}

class _AddFinanceMovimentPageState extends State<AddFinanceMovimentPage>
    with DialogMessageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: ListenableBuilder(
          listenable: widget.viewmodel,
          builder: (context, child) {
            final viewModel = widget.viewmodel;

            if (viewModel.saveFinanceMovimentCommand.isRunning) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (viewModel.saveFinanceMovimentCommand.completed) {
              Navigator.of(context).maybePop(true);
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListenableBuilder(
                        listenable: viewModel,
                        builder: (context, child) {
                          final model = viewModel.model;
                          return FinancesCardWidget(
                            isExpense: model.isExpense,
                            category: model.categoryModel,
                            data: model.data?.onlyDate,
                            payment: model.tipoDePagamento?.name,
                            value: model.value,
                            description: model.description,
                          );
                        }),
                  ),
                  Expanded(
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
                                Switch(
                                  value: viewModel.model.isExpense,
                                  onChanged: viewModel.changeIsExpense,
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
                                const Text('Pontual'),
                                Switch(
                                  value: viewModel.model.isMonthFrequency,
                                  onChanged: viewModel.changeIsMonthFrequency,
                                ),
                                const Text('Mensal'),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                    onTap: () async {
                                      final now = DateTime.now();
                                      final DateTime? dateTime =
                                          await showDatePicker(
                                        context: context,
                                        firstDate:
                                            now.subtract(Duration(days: 365)),
                                        lastDate: now.add(Duration(days: 365)),
                                        initialDate: now,
                                      );
                                      viewModel.changeDate(dateTime);
                                    },
                                    child: FormFieldWidget(
                                      label: 'Data',
                                      height: 45,
                                      child: Center(
                                        child: Text(
                                          viewModel.model.data?.onlyDate ?? '',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )),
                              ),
                              Expanded(
                                child: FormFieldWidget(
                                  label: 'Valor',
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    onChanged: viewModel.changeValue,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
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
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              onChanged: viewModel.changeDescription,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          FormFieldWidget(
                            label:
                                'Selecione uma categoria de ${viewModel.model.isExpense ? 'Despesa' : 'Receita'}',
                            child: DropdownMenu<CategoryModel>(
                              onSelected: viewModel.changeCategory,
                              width: double.infinity,
                              dropdownMenuEntries: viewModel.model.isExpense
                                  ? viewModel.expenseCategories
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
                                  : viewModel.revenueCategories
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
                            ),
                          ),
                          FormFieldWidget(
                            label:
                                'Selecione um de Tipo de ${viewModel.model.isExpense ? 'pagamento' : 'recebimento'}',
                            child: DropdownMenu<String>(
                              onSelected: viewModel.changePaymentType,
                              width: double.infinity,
                              dropdownMenuEntries: widget.viewmodel.paymentTypes
                                  .map(
                                    (e) => DropdownMenuEntry<String>(
                                      value: e.name,
                                      label: e.name,
                                      leadingIcon: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      labelWidget: Text(e.name),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ListenableBuilder(
                listenable: widget.viewmodel,
                builder: (context, child) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        BeveledRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(4),
                        ),
                      ),
                    ),
                    onPressed: widget.viewmodel.isFormValid
                        ? () => widget.viewmodel.saveFinanceMovimentCommand
                            .execute()
                        : null,
                    child: const Text('Adicionar'),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

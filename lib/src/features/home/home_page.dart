import 'package:finances_app/src/core/extensions/int_extension.dart';
import 'package:finances_app/src/core/result/result.dart';
import 'package:finances_app/src/core/widgets/finance_moviment_static_card_widget.dart';
import 'package:finances_app/src/features/home/home_viewmodel.dart';
import 'package:finances_app/src/features/home/presentation/widgets/finance_resume_card.dart';
import 'package:finances_app/src/features/home/presentation/widgets/month_header_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.homeViewModel});

  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () async {
            final result = await Navigator.of(context).pushNamed('add_finance');

            if (result != null && result is bool) {
              await homeViewModel.loadByMonthCommand();
            }
          }),
      body: ListenableBuilder(
          listenable: homeViewModel,
          builder: (context, _) {
            if (homeViewModel.loadByMonth.isRunning) {
              return Center(child: CircularProgressIndicator());
            }
            if (homeViewModel.loadByMonth.result == null) {
              return const Offstage();
            }
            if (homeViewModel.loadByMonth.completed) {
              final model = homeViewModel.loadByMonth.result!.asSucess.value;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  spacing: 8,
                  children: [
                    // ElevatedButton(
                    //     onPressed: () {
                    //       Navigator.of(context).pushNamed('log_screen');
                    //     },
                    //     child: Text('LogScreen')),
                    MonthHeaderWidget(
                      actualMonth: homeViewModel.actualMonth.monthName,
                      onSubstractMonth: homeViewModel.substractMonth,
                      onAddMonth: homeViewModel.addMonth,
                    ),
                    FinanceResumeCard(model: model),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final moviment = model.moviments[index];
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: FinancesCardStatic(
                              entry: moviment,
                              color: moviment.isExpense
                                  ? Colors.red.shade700
                                  : Colors.green.shade700,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemCount: model.moviments.length,
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Offstage();
          }),
    );
  }
}

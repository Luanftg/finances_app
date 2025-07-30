import 'package:finances_app/src/core/extensions/datetime_extension.dart';
import 'package:finances_app/src/features/finance_moviment/add_finance_moviment_widget.dart';
import 'package:finances_app/src/features/finance_moviment/data/local_finance_moviment_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddFinanceMoviment(),
              ),
            );
          }),
      body: FutureBuilder(
          future: LocalFinanceMovimentService().findAll(),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }
            if (asyncSnapshot.hasData) {
              final moviments = asyncSnapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final moviment = moviments[index];
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          spacing: 8,
                          children: [
                            Text(moviment.data.onlyDate),
                            Text(moviment.categoryModel.name),
                            Text(moviment.tipoDePagamento.name),
                            (moviment.description != null)
                                ? Text(moviment.description!)
                                : const Offstage(),
                            Text('R\$ ${moviment.value}'),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: asyncSnapshot.data!.length,
                ),
              );
            }
            return const Offstage();
          }),
    );
  }
}

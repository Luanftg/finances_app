part of widgets;

class MonthlyCalendarWidget extends StatelessWidget {
  final CalendarSelectionMode calendarSelectionMode;
  final double? height;
  final double? width;

  final CalendarStreamController controller;
  final List<DateTime> dates;
  final void Function(int)? whenTapDate;

  const MonthlyCalendarWidget({
    super.key,
    this.calendarSelectionMode = CalendarSelectionMode.single,
    this.dates = const [],
    this.height,
    this.width,
    this.whenTapDate,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CalendarState>(
      initialData: CalendarState(currentMonth: controller.state.currentMonth),
      stream: controller.calendarStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data is CalendarState) {
          final int daysInMonth = DateTime(snapshot.data!.currentMonth.year,
                  snapshot.data!.currentMonth.month + 1, 0)
              .day;
          final int startWeekday = DateTime(snapshot.data!.currentMonth.year,
                  snapshot.data!.currentMonth.month, 1)
              .weekday;
          final CalendarState state = snapshot.data!;
          if (calendarSelectionMode == CalendarSelectionMode.range) {
            final newState = state.copyWith(
                selectionMode: calendarSelectionMode,
                rangeStartDate: DateTime.now());
            controller.updateCalendarState(newState);
          } else if (calendarSelectionMode == CalendarSelectionMode.single) {
            final newState =
                state.copyWith(selectionMode: calendarSelectionMode);
            controller.updateCalendarState(newState);
          } else if (calendarSelectionMode == CalendarSelectionMode.readOnly &&
              dates.isNotEmpty) {
            final newState = state.copyWith(
                selectionMode: calendarSelectionMode,
                selectedDates: dates.toSet());
            controller.updateCalendarState(newState);
          }

          return LayoutBuilder(builder: (context, constraint) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: width ?? constraint.maxWidth,
                height: height ?? constraint.maxHeight,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            final updatedState = state.copyWith(
                              currentMonth: DateTime(
                                state.currentMonth.year,
                                state.currentMonth.month - 1,
                              ),
                            );
                            controller.updateCalendarState(updatedState);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: context.colors.primary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        FittedBox(
                          child: Text(
                            "${state.currentMonth.month.monthName} ${state.currentMonth.year}",
                            style: context.textStyles.textBold.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: context.colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        InkWell(
                          onTap: () {
                            final updatedState = state.copyWith(
                              currentMonth: DateTime(
                                state.currentMonth.year,
                                state.currentMonth.month + 1,
                              ),
                            );
                            controller.updateCalendarState(updatedState);
                          },
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: context.colors.primary,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final cellWidth = constraints.maxWidth / 7;
                          const double maxHeight =
                              60; // Defina aqui a altura máxima para as células
                          final cellHeight =
                              cellWidth > maxHeight ? maxHeight : cellWidth;

                          // Calcula o número total de células, incluindo os dias "vazios" no início do mês
                          final totalCells = daysInMonth + startWeekday - 1;

                          return SizedBox(
                            width: constraints.maxWidth,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    7, // Sempre sete colunas (dias da semana)
                                childAspectRatio: cellWidth /
                                    cellHeight, // Proporção para garantir a altura máxima
                              ),
                              itemBuilder: (context, index) {
                                // Calcula o número do dia a ser renderizado
                                final dayToRender = index - startWeekday + 2;

                                // Se o índice for antes do início do mês ou depois do final, não renderiza um dia
                                if (dayToRender <= 0 ||
                                    dayToRender > daysInMonth) {
                                  return const SizedBox.shrink();
                                } else {
                                  final date = DateTime(
                                    state.currentMonth.year,
                                    state.currentMonth.month,
                                    dayToRender,
                                  );

                                  return GestureDetector(
                                    onTap: () {
                                      if (calendarSelectionMode ==
                                              CalendarSelectionMode.readOnly &&
                                          dates.any(
                                            (element) =>
                                                element.day == dayToRender,
                                          )) {
                                        whenTapDate?.call(dayToRender);
                                        return;
                                      }
                                      final newState = state.copyWith(
                                          selectionMode: calendarSelectionMode);
                                      final updatedState =
                                          newState.toggleDateSelection(date);
                                      controller
                                          .updateCalendarState(updatedState);
                                      debugPrint(
                                          'Data Selecionada: ${date.day}-${date.month}-${date.year}');
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: context.colors.gray100,
                                        ),
                                        color: _getBackgroundColor(
                                            date, state, context),
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          (width ?? constraints.maxWidth) <=
                                                  constraints.maxWidth * 0.2
                                              ? const Offstage()
                                              : FittedBox(
                                                  child: Text(
                                                    date.diaDaSemana,
                                                    style: context
                                                        .textStyles.textLight,
                                                  ),
                                                ),
                                          FittedBox(
                                            child: Text(
                                              dayToRender.toString(),
                                              style: _getTextStyle(date, state,
                                                  context, constraints),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                              itemCount: totalCells,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        }
        return const SizedBox.shrink();
      },
    );
  }

  Color _getBackgroundColor(
      DateTime date, CalendarState state, BuildContext context) {
    if (state.selectionMode == CalendarSelectionMode.range &&
        date.day == DateTime.now().day) {
      return context.colors.primary;
    }
    if (state.selectionMode == CalendarSelectionMode.range &&
        state.rangeStartDate != null &&
        state.rangeEndDate != null &&
        date.isAfter(state.rangeStartDate!) &&
        date.isBefore(state.rangeEndDate!)) {
      return context.colors.primary;
    } else {
      return state.selectedDates.contains(date)
          ? context.colors.primary
          : context.colors.white;
    }
  }

  TextStyle _getTextStyle(
    DateTime date,
    CalendarState state,
    BuildContext context,
    BoxConstraints constraint,
  ) {
    if (state.selectionMode == CalendarSelectionMode.range &&
        date.day == DateTime.now().day) {
      return context.textStyles.textLight.copyWith(
        color: context.colors.white,
        fontSize: (width ?? MediaQuery.sizeOf(context).width) > 600 ? 16 : 14,
        fontWeight: FontWeight.w400,
      );
    }
    if (state.selectionMode == CalendarSelectionMode.range &&
        state.rangeStartDate != null &&
        state.rangeEndDate != null &&
        date.isAfter(state.rangeStartDate!) &&
        date.isBefore(state.rangeEndDate!)) {
      return context.textStyles.textLight.copyWith(
        color: context.colors.white,
        fontSize: (width ?? MediaQuery.sizeOf(context).width) > 600 ? 16 : 14,
        fontWeight: FontWeight.w400,
      );
    } else {
      final isSelected = state.selectedDates.contains(date);
      return context.textStyles.textLight.copyWith(
        color: isSelected ? context.colors.white : context.colors.black,
        fontSize: (width ?? MediaQuery.sizeOf(context).width) > 600 ? 16 : 14,
        fontWeight: FontWeight.w400,
      );
    }
  }
}

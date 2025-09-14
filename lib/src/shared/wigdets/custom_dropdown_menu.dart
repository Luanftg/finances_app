part of widgets;

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({
    super.key,
    required this.list,
    required this.width,
    required this.height,
  });
  final List<String> list;
  final double width;
  final double height;

  static String selected = 'Dinheiro';
  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<String>> stringEntries =
        <DropdownMenuEntry<String>>[];
    for (final String value in widget.list) {
      stringEntries.add(
        DropdownMenuEntry<String>(
          value: value,
          label: value,
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppCustomColors.i.white),
            textStyle:
                WidgetStatePropertyAll<TextStyle>(context.textStyles.header2),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownMenu(
        enableSearch: false,
        width: widget.width,
        selectedTrailingIcon: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppCustomColors.i.gray800,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(Icons.keyboard_arrow_up_outlined),
        ),
        trailingIcon: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppCustomColors.i.gray800,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(Icons.keyboard_arrow_down_outlined),
        ),
        textStyle: context.textStyles.header2.copyWith(
          color: AppCustomColors.i.gray500,
        ),
        initialSelection: CustomDropDownMenu.selected,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          fillColor: AppCustomColors.i.gray900,
          filled: true,
        ),
        menuStyle: MenuStyle(
          surfaceTintColor:
              WidgetStatePropertyAll<Color>(AppCustomColors.i.white),
          alignment: const FractionalOffset(0, 1.1),
          backgroundColor: WidgetStatePropertyAll(AppCustomColors.i.gray900),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
        ),
        dropdownMenuEntries: stringEntries,
        onSelected: (value) {
          setState(() {
            CustomDropDownMenu.selected = value.toString();
          });
        },
      ),
    );
  }
}

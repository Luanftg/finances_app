part of widgets;

class CustomFilterDropDownButton extends StatefulWidget {
  final List<String> list;
  final double width;
  final double height;
  const CustomFilterDropDownButton(
      {super.key,
      required this.list,
      required this.width,
      required this.height});

  @override
  State<CustomFilterDropDownButton> createState() =>
      _CustomFilterDropDownButtonState();
}

String? dropdownValue;

class _CustomFilterDropDownButtonState
    extends State<CustomFilterDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          disabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          fillColor: AppCustomColors.i.gray800,
        ),
        dropdownColor: AppCustomColors.i.gray800,
        iconDisabledColor: AppCustomColors.i.gray500,
        hint: Text(
          widget.list.first,
          style: context.textStyles.textMedium
              .copyWith(color: AppCustomColors.i.white),
        ),
        isExpanded: false,
        isDense: true,
        iconEnabledColor: AppCustomColors.i.white,
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        value: dropdownValue,
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: context.textStyles.textMedium.copyWith(
                color: AppCustomColors.i.white,
                fontSize: 15,
                letterSpacing: 0.46,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
      ),
    );
  }
}

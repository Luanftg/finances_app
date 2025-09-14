part of widgets;

class CustomOutlinedButtom extends StatefulWidget {
  final double width;
  final double height;
  final String label;
  final void Function()? onPressed;
  const CustomOutlinedButtom({
    Key? key,
    required this.width,
    required this.height,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomOutlinedButtom> createState() => _CustomOutlinedButtomState();
}

bool pressed = false;
Color btColor = AppCustomColors.i.black;

class _CustomOutlinedButtomState extends State<CustomOutlinedButtom> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.all(Radius.circular(8)),
            ),
          ),
          side: WidgetStatePropertyAll(
            BorderSide(width: 2, color: AppCustomColors.i.white),
          ),
          backgroundColor: pressed
              ? WidgetStatePropertyAll(AppCustomColors.i.white)
              : WidgetStatePropertyAll(AppCustomColors.i.white),
        ),
        onFocusChange: (value) {
          pressed = value;
          btColor = value ? AppCustomColors.i.white : AppCustomColors.i.black;
          setState(() {});
        },
        onPressed: widget.onPressed,
        child: Text(
          widget.label,
          style: context.textStyles.textButton.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.46,
            color: pressed ? AppCustomColors.i.black : AppCustomColors.i.black,
          ),
        ),
      ),
    );
  }
}

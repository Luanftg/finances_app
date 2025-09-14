part of widgets;

class CustomTextformField extends StatefulWidget {
  final String label;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final bool isPassword;
  final String? confirmPass;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final double? width;
  final double? height;
  final void Function(String?)? onChanged;
  const CustomTextformField({
    this.validator,
    super.key,
    required this.label,
    this.textInputType,
    this.controller,
    this.isPassword = false,
    this.confirmPass,
    this.inputFormatters,
    this.width,
    this.height,
    this.onChanged,
  });

  @override
  State<CustomTextformField> createState() => _CustomTextformFieldState();
}

class _CustomTextformFieldState extends State<CustomTextformField> {
  bool obscureText = true;

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        onChanged: widget.onChanged,
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        style: context.textStyles.textLabel
            .copyWith(color: AppCustomColors.i.white),
        obscureText: widget.isPassword ? obscureText : false,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4), topRight: Radius.circular(4)),
            borderSide: BorderSide(color: AppCustomColors.i.white),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: AppCustomColors.i.inputBorderColor)),
          labelText: widget.label,
          suffixIcon: widget.isPassword == true
              ? IconButton(
                  onPressed: _toggle,
                  icon: obscureText
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.visibility_outlined),
                )
              : null,
          isDense: false,
        ),
      ),
    );
  }
}

part of widgets;

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final double? height;
  final IconData? iconData;
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.width,
    this.height = 50,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: iconData != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(
                      iconData,
                      color: AppCustomColors.i.black,
                    ),
                  ),
                  Text(
                    label,
                    style: TextStyle(
                        color: AppCustomColors.i.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        letterSpacing: 0.46),
                  ),
                ],
              )
            : Text(
                label,
                style: TextStyle(
                  color: AppCustomColors.i.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
      ),
    );
  }
}

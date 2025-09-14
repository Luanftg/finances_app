part of widgets;

class CustomDialog extends StatelessWidget {
  final String text;
  final bool? isLoading;

  const CustomDialog.isLoadin({
    super.key,
    this.isLoading = true,
    required this.text,
  });

  const CustomDialog({
    super.key,
    this.isLoading = false,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(),
      backgroundColor: AppCustomColors.i.transparent,
      child: Container(
        height: 168,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppCustomColors.i.gray900,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: isLoading == true
              ? customProgressIndicator(
                  context: context,
                  text: text,
                )
              : Text(
                  text,
                  style: context.textStyles.textBanner,
                ),
        ),
      ),
    );
  }

  Column customProgressIndicator(
      {required BuildContext context, required String text}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 32),
          height: 62,
          width: 62,
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(AppCustomColors.i.primary),
            strokeWidth: 8,
          ),
        ),
        Text(
          text,
          style: context.textStyles.textBanner,
        ),
      ],
    );
  }
}

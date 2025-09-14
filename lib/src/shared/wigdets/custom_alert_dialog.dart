part of widgets;

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String cancelTitle;
  final String sucessTitle;
  final double height;
  final Function cancelOnPressed;
  final Function sucessOnPressed;
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.cancelTitle,
    required this.sucessTitle,
    required this.height,
    required this.cancelOnPressed,
    required this.sucessOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: AppCustomColors.i.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
        height: height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppCustomColors.i.gray900,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textStyles.textLabel.copyWith(
                color: AppCustomColors.i.gray50,
                fontSize: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: const WidgetStatePropertyAll(0),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.all(0),
                    ),
                    backgroundColor:
                        WidgetStatePropertyAll(AppCustomColors.i.gray900),
                  ),
                  onPressed: () => cancelOnPressed(),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppCustomColors.i.gray50)),
                    height: context.percentHeight(56 / 844),
                    width: context.percenteWidth(140 / 390),
                    child: Center(
                      child: Text(
                        cancelTitle,
                        style: context.textStyles.textRegular.copyWith(
                          color: AppCustomColors.i.gray50,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      elevation: const WidgetStatePropertyAll(0),
                      padding: const WidgetStatePropertyAll(
                        EdgeInsets.all(0),
                      ),
                      backgroundColor:
                          WidgetStatePropertyAll(AppCustomColors.i.logOut)),
                  onPressed: () => sucessOnPressed(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: context.percentHeight(56 / 844),
                    width: context.percenteWidth(140 / 390),
                    child: Center(
                      child: Text(
                        sucessTitle,
                        style: context.textStyles.textRegular.copyWith(
                          color: AppCustomColors.i.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

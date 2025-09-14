part of widgets;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData? icon;
  final String title;
  final String? titleAvatar;
  final VoidCallback? onPressed;
  final List<Widget>? actions;
  final bool isHome;

  const CustomAppBar({
    super.key,
    this.icon,
    required this.title,
    this.onPressed,
    this.actions,
    this.titleAvatar,
    this.isHome = false,
  });
  const CustomAppBar.isHome({
    super.key,
    this.icon,
    required this.title,
    this.onPressed,
    this.actions,
    required this.titleAvatar,
    this.isHome = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          isHome ? const EdgeInsets.symmetric(horizontal: 24) : EdgeInsets.zero,
      child: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: context.percentHeight(0.14),
        titleSpacing: 0,
        title: Row(
          children: [
            icon != null
                ? IconButton(
                    icon: Icon(icon),
                    onPressed: onPressed,
                  )
                : isHome
                    ? CircleAvatar(
                        child: Text(
                          titleAvatar!,
                          style: context.textStyles.textBold,
                        ),
                      )
                    : const SizedBox.shrink(),
            icon != null
                ? const SizedBox(width: 20)
                : isHome
                    ? const SizedBox(width: 12)
                    : const SizedBox(width: 24),
            Text(
              title,
              style: isHome
                  ? context.textStyles.header2
                  : context.textStyles.header.copyWith(
                      color: AppCustomColors.i.white,
                    ),
            )
          ],
        ),
        actions: actions,
        flexibleSpace: Container(
          width: context.screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppCustomColors.i.black,
                AppCustomColors.i.transparent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.4, 1],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        backgroundColor: AppCustomColors.i.transparent,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(82);
}

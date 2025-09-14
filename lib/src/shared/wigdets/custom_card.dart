part of widgets;

class CustomCard extends StatefulWidget {
  final double width;
  final double height;
  final List<Widget> children;

  const CustomCard(
      {super.key,
      required this.width,
      required this.height,
      required this.children});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppCustomColors.i.gray800,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.children,
        ),
      ),
    );
  }
}

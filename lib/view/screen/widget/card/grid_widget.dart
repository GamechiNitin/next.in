import 'package:next/utils/import.dart';
import 'package:next/view/screen/widget/image_widget.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({super.key, this.scrollDirection});
  final Axis? scrollDirection;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "Grid List",
            style: GoogleFonts.mogra(
              fontSize: size16,
              color: kBlackColor,
            ),
          ),
        ),
        SizedBox(
          height: scrollDirection != null ? 250 : null,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: scrollDirection != null
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            scrollDirection: scrollDirection ?? Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: scrollDirection != null ? 2 : 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return ImageWidget(isEven: index.isEven);
            },
          ),
        )
      ],
    );
  }
}

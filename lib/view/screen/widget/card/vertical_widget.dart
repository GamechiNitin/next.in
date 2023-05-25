import 'package:next/utils/import.dart';
import 'package:next/view/screen/widget/image_widget.dart';

class VerticalWidget extends StatelessWidget {
  const VerticalWidget({super.key, this.itemCount});
  final int? itemCount;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "Veritcal List",
            style: GoogleFonts.mogra(
              fontSize: size16,
              color: kBlackColor,
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: itemCount ?? 5,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return ImageWidget(
              isEven: index.isEven,
              height: 150,
            );
          },
        ),
      ],
    );
  }
}

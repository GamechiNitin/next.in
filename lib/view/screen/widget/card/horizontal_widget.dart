import 'package:next/utils/import.dart';
import 'package:next/view/screen/widget/image_widget.dart';

class HorizontalWidget extends StatelessWidget {
  const HorizontalWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "Horizontal List",
            style: GoogleFonts.mogra(
              fontSize: size16,
              color: kBlackColor,
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 25,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ImageWidget(
                isEven: index.isEven,
                height: 150,
                width: 150,
              );
            },
          ),
        ),
      ],
    );
  }
}

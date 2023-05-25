import 'package:next/utils/import.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.isEven, this.height, this.width});
  final bool isEven;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: kWhiteColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.white30,
            offset: Offset(5, 5),
            blurRadius: 10,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: kWhiteColor,
            offset: Offset(-5, -5),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.network(isEven ? ImageLink.link1 : ImageLink.link3,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: Text(
              "Loading...",
              style: TextStyle(fontSize: 10),
            ),
          );
        }),
      ),
    );
  }
}

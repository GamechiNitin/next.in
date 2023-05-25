import 'package:next/utils/import.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order",
          style: GoogleFonts.mogra(
            fontSize: size24,
            color: kPrimaryColor,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HorizontalWidget(),
            GridWidget(scrollDirection: Axis.horizontal),
            VerticalWidget(itemCount: 50),
          ],
        ),
      ),
    );
  }
}

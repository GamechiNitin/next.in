import 'package:next/utils/import.dart';

class NextHomeScreen extends StatelessWidget {
  const NextHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NextApp",
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
            VerticalWidget(),
            GridWidget(),
          ],
        ),
      ),
    );
  }
}

import 'package:next/utils/import.dart';
import 'package:next/view/screen/authentication/login_screen.dart';

class DialogBoxWidget {
  static Future<void> logOutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
            ),
            child: Text(
              'Log Out',
              style: GoogleFonts.mogra(
                fontSize: size24,
                color: kWhiteColor,
              ),
            ),
          ),
          content: Text(
            'Are you sure you want to logout ?',
            textAlign: TextAlign.center,
            style: GoogleFonts.mogra(
              fontSize: size20,
              color: kBlack54Color,
            ),
          ),
          actions: <Widget>[
            ButtonWidget(
              text: "Yes",
              color: kRedColor,
              margin: EdgeInsets.zero,
              onTap: () {
                Navigator.pop(context);
                LocalDb.clear();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LogInScreen(),
                    ),
                    (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}

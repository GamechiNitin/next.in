import 'dart:async';
import 'package:next/model/user_model.dart';
import 'package:next/utils/import.dart';
import 'package:next/view/screen/authentication/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    iniTimer();
  }

  Future<void> iniTimer() async {
    Timer(const Duration(seconds: 1), checkUser);
  }

  Future<void> checkUser() async {
    UserModel? userModel = await LocalDb.getCurrentUser();
    if (userModel?.uuid != null) {
      goToHome();
    } else {
      goToLogIn();
    }
  }

  void goToHome() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainPage()),
      (route) => false,
    );
  }

  void goToLogIn() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LogInScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Next",
          textAlign: TextAlign.center,
          style: GoogleFonts.mogra(
            fontSize: 50,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}

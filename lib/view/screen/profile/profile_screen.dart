// ignore_for_file: depend_on_referenced_packages

import 'package:next/model/user_model.dart';
import 'package:next/utils/import.dart';
import 'package:next/view/screen/authentication/forgot_password_sceen.dart';
import 'package:next/view/screen/widget/dialog_box_widget.dart';
import 'package:collection/collection.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    getUSer();
  }

  Future<void> getUSer() async {
    UserModel? puserModel = await LocalDb.getCurrentUser();
    List<UserModel> userModelList = await LocalDb.getUserList();
    userModel = userModelList
        .firstWhereOrNull((element) => element.email == puserModel?.email);

    _notify();
  }

  _notify() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        title: Text(
          "Profile",
          style: GoogleFonts.mogra(
            fontSize: size24,
            color: kPrimaryColor,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),
          Column(
            children: [
              Image.asset(
                ImageAssets.profileImage,
                width: MediaQuery.of(context).size.width / 2,
              ),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            "Profile Details",
            textAlign: TextAlign.center,
            style: GoogleFonts.mogra(
              fontSize: size24,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Name : ",
                style: GoogleFonts.mogra(
                  fontSize: size16,
                  color: kBlackColor,
                ),
              ),
              Text(
                userModel?.name ?? "Unknown Username",
                style: GoogleFonts.mogra(
                  fontSize: size16,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Email : ",
                style: GoogleFonts.mogra(
                  fontSize: size16,
                  color: kBlackColor,
                ),
              ),
              Text(
                userModel?.email ?? "Unknown Email",
                style: GoogleFonts.mogra(
                  fontSize: size16,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              LocalDb.clearDb();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                  (route) => false);
            },
            child: Text(
              "DeleteDatabase",
              textAlign: TextAlign.center,
              style: GoogleFonts.mogra(
                fontSize: size14,
                color: kRedColor,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ButtonWidget(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordScreen(
                      email: userModel?.email ?? "no email found",
                    ),
                  ),
                );
              },
              text: "Update Password",
              color: kBlueColor,
            ),
            ButtonWidget(
              onTap: () {
                DialogBoxWidget.logOutDialog(context);
              },
              text: "LogOut",
            ),
          ],
        ),
      ),
    );
  }
}

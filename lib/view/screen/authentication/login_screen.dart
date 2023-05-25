// ignore_for_file: use_build_context_synchronously
import 'package:next/model/user_model.dart';
import 'package:next/utils/helper.dart';
import 'package:next/utils/import.dart';
import 'package:next/utils/strings.dart';
import 'package:next/view/screen/authentication/forgot_password_sceen.dart';
import 'package:next/view/screen/authentication/signup_screen.dart';
import 'package:uuid/uuid.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailIdFn = FocusNode();
  FocusNode passwordFn = FocusNode();
  String? emailErrorText;
  String? passwordErrorText;

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool obscureText = true;

  _notify() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    passwordFn.unfocus();
    emailIdController.clear();
    passwordController.clear();
    emailIdFn.unfocus();
    super.dispose();
  }

  void gotoForgotPasswordScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgotPasswordScreen(
          email: emailIdController.text.trim(),
        ),
      ),
    );
  }

  void gotoHomeScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
      (route) => false,
    );
  }

  void gotoSignUpPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                gotoHomeScreen();
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  fontSize: size16,
                  color: kBlackColor,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding:
                const EdgeInsets.only(bottom: 50, top: 20, left: 20, right: 20),
            children: [
              Text(
                "Welcome to Next!",
                textAlign: TextAlign.center,
                style: GoogleFonts.mogra(
                  fontSize: size24,
                  color: kPrimaryColor,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Image.asset(
                    ImageAssets.logInImage,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'LogIn',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 16,
                      ),
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormWidget(
                      textInputAction: TextInputAction.next,
                      controller: emailIdController,
                      focusNode: emailIdFn,
                      label: 'Enter email : test@gmail.com',
                      prefixIcon: Icons.email,
                      errorText: emailErrorText,
                      onEditingComplete: () {
                        if (emailIdController.text.isEmpty) {
                          emailErrorText = 'Enter the Email Id';
                        } else if (!emailIdController.text.contains('@') ||
                            !emailIdController.text.contains('.')) {
                          emailErrorText = 'Enter valid the email';
                        } else {
                          emailErrorText = null;
                        }
                        _notify();
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          emailErrorText = 'Enter the Email Id';
                          return emailErrorText;
                        } else if (!val.contains('@') || !val.contains('.')) {
                          emailErrorText = 'Enter valid the email';
                          return emailErrorText;
                        } else {
                          emailErrorText = null;
                          return emailErrorText;
                        }
                      },
                      onChanged: (val) {
                        if (val.isEmpty) {
                          emailErrorText = 'Enter the Email Id';
                        } else if (!val.contains('@') || !val.contains('.')) {
                          emailErrorText = 'Enter valid the email';
                        } else {
                          emailErrorText = null;
                        }
                        _notify();
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormWidget(
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      controller: passwordController,
                      focusNode: passwordFn,
                      label: 'Enter Password',
                      prefixIcon: Icons.lock,
                      suffixIcon:
                          obscureText ? Icons.visibility : Icons.visibility_off,
                      obscureText: obscureText,
                      errorText: passwordErrorText,
                      onSuffixIxonTap: () {
                        obscureText = !obscureText;
                        _notify();
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return passwordErrorText =
                              AppString.passwordIsEmptyValidation;
                        } else if (!Helper.validatePassowrd(val)) {
                          return passwordErrorText =
                              AppString.passwordValidation;
                        } else if (val.length < 8) {
                          return passwordErrorText =
                              AppString.passwordLengthValidation;
                        } else {
                          passwordErrorText = null;
                          return passwordErrorText;
                        }
                      },
                      onChanged: (val) {
                        if (val.isEmpty) {
                          passwordErrorText =
                              AppString.passwordIsEmptyValidation;
                        } else if (!Helper.validatePassowrd(val)) {
                          passwordErrorText = AppString.passwordValidation;
                        } else if (val.length < 8) {
                          passwordErrorText =
                              AppString.passwordLengthValidation;
                        } else {
                          passwordErrorText = null;
                        }
                        _notify();
                      },
                      onEditingComplete: () {
                        if (passwordController.text.isEmpty) {
                          passwordErrorText =
                              AppString.passwordIsEmptyValidation;
                        } else if (!Helper.validatePassowrd(
                            passwordController.text.trim())) {
                          passwordErrorText = AppString.passwordValidation;
                        } else if (passwordController.text.length < 8) {
                          passwordErrorText =
                              AppString.passwordLengthValidation;
                        } else {
                          passwordErrorText = null;
                          passwordFn.unfocus();
                        }
                        _notify();
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        gotoForgotPasswordScreen();
                      },
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            fontSize: size14,
                            color: kBlueColor,
                          ),
                        ),
                      ),
                    ),
                    ButtonWidget(
                      text: 'Log In',
                      onTap: () async {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          _loading(true);
                          Future.delayed(const Duration(seconds: 2), () async {
                            UserModel userModel = UserModel(
                              email: emailIdController.text.trim(),
                              password: passwordController.text.trim(),
                              uuid: const Uuid().v4(),
                            );
                            final validationRecord =
                                await LocalDb.checkPassword(userModel);
                            Helper.toast(context, validationRecord.$1,
                                success: validationRecord.$2);
                            if (validationRecord.$2) {
                              await LocalDb.saveCurrentUser(userModel);
                              _loading(false);
                              gotoHomeScreen();
                            }
                            _loading(false);
                          });
                        }
                      },
                    ),
                    Text(
                      'or',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(300),
                        color: kWhiteColor,
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black12,
                            offset: Offset(6, 6),
                            spreadRadius: 1,
                            blurRadius: 4,
                          ),
                          BoxShadow(
                            color: Colors.indigoAccent.withOpacity(0.1),
                            offset: const Offset(-6, -6),
                            spreadRadius: 1,
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageAssets.googleIconImage,
                            height: 30,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Login with Google",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        gotoSignUpPage();
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: const [
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                fontSize: size16,
                                color: kBlueColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isLoading) Helper.progress(),
        ],
      ),
    );
  }

  _loading(bool loaad) {
    isLoading = loaad;
    _notify();
  }
}

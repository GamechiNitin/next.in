// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:next/model/user_model.dart';
import 'package:next/utils/helper.dart';
import 'package:next/utils/import.dart';
import 'package:next/utils/strings.dart';
import 'package:uuid/uuid.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  FocusNode nameFn = FocusNode();
  FocusNode emailFn = FocusNode();
  FocusNode passwordFn = FocusNode();
  FocusNode confirmPasswordFn = FocusNode();
  String? emailErrorText;
  String? nameErrorText;
  String? passwordErrorText;
  String? confirmPasswordErrorText;
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isTermOfUse = false;
  bool obscureText = true;
  bool obscureConfirmPassword = true;

  _notify() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    passwordFn.unfocus();
    nameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    confirmPasswordFn.unfocus();
    nameFn.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  Image.asset(
                    ImageAssets.signUpImage,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'SignUp',
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
                          controller: nameController,
                          focusNode: nameFn,
                          label: 'Enter name',
                          prefixIcon: Icons.person,
                          errorText: nameErrorText,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return nameErrorText = 'Enter your name';
                            } else {
                              return nameErrorText = null;
                            }
                          },
                          onEditingComplete: () {
                            if (nameController.text.isEmpty) {
                              nameErrorText = 'Enter your name';
                            } else {
                              nameErrorText = null;
                            }
                            _notify();
                          },
                          onChanged: (val) {
                            if (val.isEmpty) {
                              nameErrorText = 'Enter your name';
                            } else {
                              nameErrorText = null;
                            }
                            _notify();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormWidget(
                          controller: emailController,
                          focusNode: emailFn,
                          label: 'Enter email : test@gmail.com',
                          prefixIcon: Icons.email,
                          errorText: emailErrorText,
                          onEditingComplete: () {
                            if (emailController.text.isEmpty) {
                              emailErrorText = 'Enter the Email Id';
                            } else if (!emailController.text.contains('@') ||
                                !emailController.text.contains('.')) {
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
                            } else if (!val.contains('@') ||
                                !val.contains('.')) {
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
                            } else if (!val.contains('@') ||
                                !val.contains('.')) {
                              emailErrorText = 'Enter valid the email';
                            } else {
                              emailErrorText = null;
                            }
                            _notify();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormWidget(
                          controller: passwordController,
                          focusNode: passwordFn,
                          label: 'Create Password',
                          prefixIcon: Icons.lock,
                          maxLines: 1,
                          suffixIcon: obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                            }
                            _notify();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormWidget(
                          controller: confirmPasswordController,
                          focusNode: confirmPasswordFn,
                          label: 'Confirm Password',
                          prefixIcon: Icons.lock,
                          maxLines: 1,
                          suffixIcon: obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          obscureText: obscureConfirmPassword,
                          errorText: confirmPasswordErrorText,
                          onSuffixIxonTap: () {
                            obscureConfirmPassword = !obscureConfirmPassword;
                            _notify();
                          },
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return confirmPasswordErrorText =
                                  AppString.passwordIsEmptyValidation;
                            } else if (!Helper.validatePassowrd(val)) {
                              return confirmPasswordErrorText =
                                  AppString.passwordValidation;
                            } else if (val.length < 8) {
                              return confirmPasswordErrorText =
                                  AppString.passwordLengthValidation;
                            } else if (passwordController.text.trim() !=
                                confirmPasswordController.text.trim()) {
                              return confirmPasswordErrorText =
                                  AppString.passwordSameValidation;
                            } else {
                              confirmPasswordErrorText = null;
                              return confirmPasswordErrorText;
                            }
                          },
                          onChanged: (val) {
                            if (val.isEmpty) {
                              confirmPasswordErrorText =
                                  AppString.passwordIsEmptyValidation;
                            } else if (!Helper.validatePassowrd(val)) {
                              confirmPasswordErrorText =
                                  AppString.passwordValidation;
                            } else if (val.length < 8) {
                              confirmPasswordErrorText =
                                  AppString.passwordLengthValidation;
                            } else if (passwordController.text.trim() !=
                                confirmPasswordController.text.trim()) {
                              confirmPasswordErrorText =
                                  AppString.passwordSameValidation;
                            } else {
                              confirmPasswordErrorText = null;
                            }
                            _notify();
                          },
                          onEditingComplete: () {
                            if (confirmPasswordController.text.isEmpty) {
                              confirmPasswordErrorText =
                                  AppString.passwordIsEmptyValidation;
                            } else if (!Helper.validatePassowrd(
                                confirmPasswordController.text.trim())) {
                              confirmPasswordErrorText =
                                  AppString.passwordValidation;
                            } else if (passwordController.text.length < 8) {
                              confirmPasswordErrorText =
                                  AppString.passwordLengthValidation;
                            } else if (passwordController.text.trim() !=
                                confirmPasswordController.text.trim()) {
                              confirmPasswordErrorText =
                                  AppString.passwordSameValidation;
                            } else {
                              confirmPasswordErrorText = null;
                            }
                            _notify();
                          },
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            isTermOfUse = !isTermOfUse;
                            _notify();
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                margin: const EdgeInsets.only(right: 8),
                                child: Checkbox(
                                  value: isTermOfUse,
                                  onChanged: (onChanged) {
                                    if (onChanged != null) {
                                      isTermOfUse = !isTermOfUse;
                                      _notify();
                                    }
                                  },
                                ),
                              ),
                              RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: "By procedding, I accept ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontSize: 12,
                                      ),
                                  children: [
                                    TextSpan(
                                      text: "Next",
                                      style: TextStyle(
                                        fontSize: size12,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' T&C ',
                                      style: TextStyle(
                                        fontSize: size12,
                                        color: kBlueColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' and ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontSize: 12,
                                          ),
                                    ),
                                    const TextSpan(
                                      text: ' Privacy Policy.',
                                      style: TextStyle(
                                        fontSize: size12,
                                        color: kBlueColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        ButtonWidget(
                          text: 'Create Account',
                          onTap: () async {
                            confirmPasswordFn.unfocus();

                            _formKey.currentState?.validate();
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate() &&
                                isTermOfUse == false) {
                              Helper.toast(
                                  context, "Accept T&C and Privcy Policy");
                            } else if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              _loading(true);
                              Future.delayed(const Duration(seconds: 2),
                                  () async {
                                UserModel userModel = UserModel(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  name: nameController.text.trim(),
                                  uuid: const Uuid().v4(),
                                );
                                bool isValid = await LocalDb.saveUserList(
                                    userModel, context);
                                if (isValid) {
                                  bool currentUser =
                                      await LocalDb.saveCurrentUser(userModel);
                                  log(currentUser.toString());
                                  if (currentUser) {
                                    Helper.toast(
                                        context, "User Login Successfully",
                                        success: true);
                                    _loading(false);

                                    gotoHomePage();
                                  } else {
                                    _loading(false);
                                    Helper.toast(context,
                                        "Something went wrong. Try again Later!");
                                  }
                                } else {
                                  _loading(false);
                                  Helper.toast(context, "Failed to save user");
                                }
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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

  gotoHomePage() {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
      (route) => false,
    );
  }
}

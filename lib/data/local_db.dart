// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:collection/collection.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:next/model/user_model.dart';
import 'package:next/utils/helper.dart';
import 'package:next/utils/import.dart';
import 'package:next/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDb {
  static Future<bool> saveCurrentUser(UserModel newUserModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool value = await sharedPreferences.setString(
      AppString.currentUserPref,
      jsonEncode(newUserModel),
    );
    return value;
  }

  static Future<UserModel?> getCurrentUser() async {
    UserModel? userModel;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(AppString.currentUserPref);

    if (data != null) {
      try {
        userModel = UserModel.fromJson(jsonDecode(data));
        log(userModel.toJson().toString());

        return userModel;
      } catch (e) {
        log(e.toString());
      }
    }
    return userModel;
  }

  static Future updateUserPasswordList(UserModel newUserModel) async {
    List<UserModel> oldUserList = await getUserList();
    oldUserList.removeWhere((element) => element.email == newUserModel.email);

    oldUserList.add(newUserModel);
    var res = UserResponse(results: oldUserList);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool val = await sharedPreferences.setString(
        AppString.userListPref, jsonEncode(res.toJson()));

    return val;
  }

  static Future<bool> saveUserList(
      UserModel newUserModel, BuildContext context) async {
    List<UserModel> oldUserList = await getUserList();

    // Check User
    if (oldUserList.isEmpty) {
      List<UserModel> userModelList = [];
      userModelList.add(newUserModel);
      var res = UserResponse(results: userModelList);
      log(newUserModel.toJson().toString());
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool val = await sharedPreferences.setString(
          AppString.userListPref, jsonEncode(res.toJson()));

      return val;
    } else {
      bool doesUserIsPresentInDB = await checkDBBooking(
        context: context,
        newUserModel: newUserModel,
        savedDataList: oldUserList,
      );
      if (doesUserIsPresentInDB == false) {
        oldUserList.add(newUserModel);
        var res = UserResponse(results: oldUserList);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        bool val = await sharedPreferences.setString(
            AppString.userListPref, jsonEncode(res.toJson()));

        log(res.toJson().toString());
        return val;
      }
    }
    return false;
  }

  static Future<List<UserModel>> getUserList() async {
    List<UserModel> bookingModelList = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.clear();
    String? data = sharedPreferences.getString(
      AppString.userListPref,
    );

    if (data != null) {
      try {
        UserResponse bookingResponse = UserResponse.fromJson(jsonDecode(data));
        if (bookingResponse.results != null) {
          return bookingResponse.results!;
        }
      } catch (e) {
        log(e.toString());
      }
    }

    return bookingModelList;
  }

  static void clear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(AppString.currentUserPref);
  }

  static void clearDb() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  static Future<(String, bool)> changePassword(
      UserModel newUserModel, BuildContext context) async {
    List<UserModel> oldUserList = await getUserList();
    if (oldUserList.isEmpty) return ("No user found with this email", false);

    UserModel? model = oldUserList
        .firstWhereOrNull((element) => element.email == newUserModel.email);
    if (model != null &&
        model.email == newUserModel.email &&
        model.password != newUserModel.oldpassword) {
      return ("Current password is wrong", false);
    } else if (model != null &&
        model.email == newUserModel.email &&
        model.password != newUserModel.password) {
      UserModel userModel = UserModel(
        email: model.email,
        name: model.name,
        uuid: model.uuid,
        password: newUserModel.password,
      );
      bool isValid = await LocalDb.updateUserPasswordList(userModel);

      if (isValid) {
        bool currentUser = await LocalDb.saveCurrentUser(userModel);
        log(currentUser.toString());
        return ("Password updated Successfully", true);
      }
    }
    log("Old ${model!.toJson().toString()}");
    log("New ${newUserModel.toJson().toString()}");
    return ("Password update failed", false);
  }

  static Future<(String, bool)> checkPassword(UserModel newUserModel) async {
    List<UserModel> oldUserList = await getUserList();
    if (oldUserList.isEmpty) return ("No user found", false);

    UserModel? model = oldUserList
        .firstWhereOrNull((element) => element.email == newUserModel.email);
    if (model != null &&
        model.email == newUserModel.email &&
        model.password != newUserModel.password) {
      return ("Invalid password", false);
    } else {
      return ("User LogIn Successfully", true);
    }
  }

  static Future<bool> checkDBBooking({
    required List<UserModel> savedDataList,
    required UserModel newUserModel,
    required BuildContext context,
  }) async {
    bool exits =
        savedDataList.every((element) => element.email == newUserModel.email);

    if (exits) {
      Helper.toast(context, "User already exits");
      return true;
    } else {
      return false;
    }
  }
}

class ImageLink {
  static const String link1 = "https://picsum.photos/200";
  static const String link2 = "https://picsum.photos/200/300?grayscale";
  static const String link3 = "https://picsum.photos/200/300/?blur=2";
}

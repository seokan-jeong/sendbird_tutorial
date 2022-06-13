import 'package:flutter/material.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbird_tutorial/sendbird.dart';

class LoginViewModel with ChangeNotifier{
  bool isLoading = false;

  //// seokan
// final userId = '334251';
// final userAccessToken = '41dca329b085ffcde798028b0adb4829cd9a2661';

// // james
// final userId = 'james';
// final userAccessToken = '772718e89c8ac080a09a694fbe2d017407a2fd8c';

// peter
  final userId = 'peter';
  final userAccessToken = 'e8b4f7373285f55d55efed6e22b97b68d40c3cd9';

  LoginViewModel();

  Future<void> login() async{
    if(userId == ''){
      throw Error();
    }

    isLoading = true;
    notifyListeners();

    try{
      sendbird.setLogLevel(LogLevel.none);
      user = await sendbird.connect(userId, accessToken: userAccessToken);
      isLoading = false;
      notifyListeners();
    }catch(e){
      isLoading = false;
      notifyListeners();
      print('login_view.dart: _signInButton: Error $e');
    }
  }
}
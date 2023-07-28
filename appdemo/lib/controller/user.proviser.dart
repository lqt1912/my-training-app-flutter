import 'package:flutter/cupertino.dart';
import '../model/user.dart';


class Security with ChangeNotifier {
  String authorization = "";
  changeAuthorization(String authorizationNew) {
    authorization = authorizationNew;
    notifyListeners();
  }

  UserLogin user = UserLogin();
  changeUser(UserLogin newUser) {
    user = newUser;
    notifyListeners();
  }

}

import 'package:amazon_clone/model/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    email: '',
    password: '',
    type: '',
    name: '',
    address: '',
    token: '',
  );

  User get user => _user;

  void setUser(String user){
   _user = User.fromJson(user);
   notifyListeners();
  }
}

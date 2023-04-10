import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_architecture/repository/auth_repo.dart';
import 'package:mvvm_architecture/utils/routes/routes_name.dart';

import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _looding = false;
  bool get loading => _looding;

  bool _signUpLoading = false;
  bool get signUploading => _signUpLoading;

  void setSignUpLoading(bool value){
    _signUpLoading = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _looding = value;
    notifyListeners();
  }



  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);

      Utils.flushBarErrorMessage('Login Successfully', context);
      Navigator.pushNamed(context, RouteName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);

      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
  Future<void> resgisterApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    _myRepo.resgisterApi(data).then((value) {
      setSignUpLoading(false);

      Utils.flushBarErrorMessage('SignUp Successfully', context);
      Navigator.pushNamed(context, RouteName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);

      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
}

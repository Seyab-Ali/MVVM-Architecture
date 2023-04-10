import 'package:mvvm_architecture/data/network/BaseApiServices.dart';
import 'package:mvvm_architecture/data/network/NetworkApiServices.dart';
import 'package:mvvm_architecture/res/app_url.dart';

class AuthRepository {
  final BaseApiServices _baseApiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _baseApiServices.getPostApiResponse(
          AppUrl.loginApiEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> resgisterApi(dynamic data) async {
    try {
      dynamic response = await _baseApiServices.getPostApiResponse(
          AppUrl.registeredApiEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}

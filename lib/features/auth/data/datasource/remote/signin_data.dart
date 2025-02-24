import 'package:al_amine_store/common/class/curd.dart';
import 'package:al_amine_store/common/class/linkapi.dart';

class SigninData {
  Crud crud;

  SigninData(this.crud);

  postData(String username, String password) async {
    var response = await crud.postData(AppLink.signIn, {
      "password": password,
      "username": username,
    });
    return response.fold((l) => l, (r) => r);
  }
}

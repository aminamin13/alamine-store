import 'package:al_amine_store/common/class/curd.dart';
import 'package:al_amine_store/common/class/linkapi.dart';

class ExpensesDataSource {
  Crud crud;

  ExpensesDataSource(this.crud);

  addData(
      {required String name,
      required String location,
      required String note,
      String? date,
      required String price}) async {
    var requestData = {
      'expenses_name': name,
      'expenses_location': location,
      'expenses_note': note,
      'expenses_date': DateTime.now().toString(),
      'expenses_price': price,
    };

    var response = await crud.postData(AppLink.addExpenses, requestData);
    return response.fold((l) => l, (r) => r);
  }

  viewData() async {
    var response = await crud.postData(AppLink.viewExpenses, {});
    return response.fold((l) => l, (r) => r);
  }

  deleteData(String id) async {
    var response = await crud.postData(AppLink.deleteExpenses, {"id": id});
    return response.fold((l) => l, (r) => r);
  }
}

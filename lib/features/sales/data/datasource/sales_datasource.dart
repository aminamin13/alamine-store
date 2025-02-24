import 'package:al_amine_store/common/class/curd.dart';
import 'package:al_amine_store/common/class/linkapi.dart';

class SalesDataSource {
  Crud crud;

  SalesDataSource(this.crud);

  viewData() async {
    var response = await crud.postData(AppLink.viewSales, {});
    return response.fold((l) => l, (r) => r);
  }



  deleteData(
    String id,
  ) async {
    var response = await crud.postData(AppLink.deleteSales, {
      "id": id,
    });
    return response.fold((l) => l, (r) => r);
  }

  editCountNumber(String id) async {
    var response = await crud.postData(AppLink.editCountNumber, {
      "items_id": id,
      
    });
    return response.fold((l) => l, (r) => r);
  }
}

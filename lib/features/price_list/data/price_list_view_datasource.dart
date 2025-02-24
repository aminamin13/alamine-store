import 'package:al_amine_store/common/class/curd.dart';
import 'package:al_amine_store/common/class/linkapi.dart';
import 'package:al_amine_store/common/class/status_request.dart';
import 'package:dartz/dartz.dart';

class PriceListViewDatasource {
  Crud crud;
  PriceListViewDatasource(this.crud);

  viewData() async {
    var response = await crud.postData(AppLink.viewProduct, {});
    return response.fold((l) => l, (r) => r);
  }

  viewImages(String id) async {
    var response = await crud.postData(AppLink.viewImages, {"items_id": id});
    return response.fold((l) => l, (r) => r);
  }

  deleteData(Map data) async {
    // Send data to the server using the POST request
    var response = await crud.postData(AppLink.deleteProduct, data);

    // Use fold to handle the success and failure cases
    return response.fold(
      (failure) {
        print("Error during deletion: $failure");
        return {"status": "error", "message": "Server error: $failure"};
      },
      (success) {
        try {
          print("Raw success response: $success");

          // Handle empty response issue
          if (success.toString().trim().isEmpty) {
            print("Error: Empty response from server");
            return {"status": "error", "message": "Empty response from server"};
          }

          // Ensure success is a Map before returning it
          if (success is Map<String, dynamic>) {
            return success;
          } else {
            print("Unexpected response format: $success");
            return {"status": "error", "message": "Unexpected response format"};
          }
        } catch (e) {
          print("Error during response handling: $e");
          return {"status": "error", "message": "Error handling response"};
        }
      },
    );
  }

  editData(Map data) async {
    Either<StatusRequest, Map> response;
    response = await crud.postData(AppLink.editProduct, data);
    return response.fold((l) => l, (r) => r);
  }

  // postDataWithImage(
  //     {required int itemID,
  //     required String itemCarType,
  //     required String itemName,
  //     required String itemYear,
  //     required String itemColor,
  //     required String itemLocation,
  //     required String itemPrice,
  //     required String itemSellPrice,
  //     required String itemNote,
  //     required String itemCount,

  //     required File? image}) async {
  //   var result = await crud.addRequestWithImageOne(
  //       AppLink.editProduct,
  //       {
  //         "items_id": itemID,
  //         "car_type": itemCarType,
  //         "name": itemName,
  //         "year": itemYear,
  //         "color": itemColor,
  //         "location": itemLocation,
  //         "price": itemPrice,
  //         "sellprice": itemSellPrice,
  //         "note": itemNote,
  //         "datenow": DateTime.now().toString(),
  //         "item_count": itemCount
  //       },
  //       image);
  //   print("Response from API: $result");
  //   return result.fold((l) => l, (r) => r);
  // }

  salesData({
    required String salesCustomer,
    required String salesItemLocation,
    required String salesItemName,
    required String salesItemCarType,
    required String salesItemYear,
    required String salesPrice,
    required String salesProfit,
    required String itemsId,
    required String itemCount,
  }) async {
    var requestData = {
      "sales_customer": salesCustomer,
      "sales_item_location": salesItemLocation,
      "sales_item_name": salesItemName,
      "sales_item_car_type": salesItemCarType,
      "sales_item_year": salesItemYear,
      "sales_price": salesPrice,
      "sales_profit": salesProfit,
      "sales_date": DateTime.now().toString(), // Add the current date and time
      "items_id": itemsId,
      "item_count": itemCount,
    };

    print("Sending request data: $requestData");

    var result = await crud.postData(AppLink.addSales, requestData);

    // Debugging response
    print("Response from API: $result");

    return result.fold((l) => l, (r) => r);
  }
}

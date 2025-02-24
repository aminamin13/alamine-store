import 'package:al_amine_store/common/class/curd.dart';
import 'package:al_amine_store/common/class/linkapi.dart';
import 'package:image_picker/image_picker.dart';

class AddProductData {
  Crud crud;

  AddProductData(this.crud);

  getLatestItemId() async {
    // Sending request to get the latest item_id
    var result = await crud.postData(AppLink.maxProductId, {});

    // Checking if the result is an error
    return result.fold((l) {
      // Handle error case
      return "Error: $l"; // Return error message as a string
    }, (r) {
      // Extract 'max_id' from the response map
      if (r.containsKey('max_id')) {
        return r['max_id'].toString(); // Return the max_id as a string
      } else {
        return "Error: max_id not found"; // Handle missing max_id case
      }
    });
  }

  postData({
    required String itemCarType,
    required String itemName,
    required String itemYear,
    required String itemColor,
    required String itemLocation,
    required String itemPrice,
    required String itemSellPrice,
    required String itemNote,
    required String itemCount

  }) async {
    // Get the latest item_id and increment it by 1
    String latestItemId = await getLatestItemId();
    int itemId = int.parse(latestItemId) + 1;
    var requestData = {
      "id": itemId.toString(),
      "car_type": itemCarType,
      "name": itemName,
      "year": itemYear,
      "color": itemColor,
      "location": itemLocation,
      "price": itemPrice,
      "sellprice": itemSellPrice,
      "note": itemNote,
      "datenow": DateTime.now().toString(),
      "item_count": itemCount

    };

    print("Sending request data: $requestData");

    var result = await crud.postData(AppLink.addProduct, requestData);

    // Debugging response
    print("Resp888888onse from API: $result");

    return result.fold((l) => l, (r) => r);
  }

  postImagesData(
      {required List<XFile>? images, required String itemsId}) async {
    if (images == null || images.isEmpty) {
      print("No images provided.");
      return {"error": "No images provided"};
    }

    var result = await crud.addRequestWithMultipleImages(
      AppLink.addImages,
      {"items_id": itemsId},
      images,
    );

    return result.fold((l) => l, (r) => r);
  }
}

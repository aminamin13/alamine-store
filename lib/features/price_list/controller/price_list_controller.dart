import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/features/price_list/data/price_list_view_datasource.dart';
import 'package:al_amine_store/features/products/data/model/image_model.dart';
import 'package:al_amine_store/features/products/data/model/products_model.dart';
import 'package:al_amine_store/functions/handlingdatacontroller.dart';
import 'package:al_amine_store/utlis/const/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class PriceListController extends GetxController  {
  getData();
}

class PriceListControllerImpl extends PriceListController {
  late StatusRequest statusRequest;
  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];
  ProductModel? productModel;
  List<ImageModel> images = [];
  String searchQuery = '';
  late TextEditingController searchController;

  PriceListViewDatasource productData = PriceListViewDatasource(Get.find());

  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      allProducts.clear(); // Clear existing data
      filteredProducts.clear();

      var response = await productData.viewData();
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          List datalist = response['data'];
          allProducts = datalist.map((e) => ProductModel.fromJson(e)).toList();

          filteredProducts = List.from(allProducts); // Initially, show all data

          print("asdasdasdasdasdasd${allProducts.last.id}");
        } else {
          null;
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  
  void search(String query) {
    searchQuery = query;
    if (query.isEmpty) {
      filteredProducts = List.from(allProducts); // Reset to show all data
    } else {
      filteredProducts = allProducts.where((product) {
        final productName = product.name?.toLowerCase() ?? '';
        final productYear = product.year?.toString() ??
            ''; // Assuming `year` is an integer or string
        final productCarType = product.carType?.toLowerCase() ??
            ''; // Assuming `carType` is a string

        // Check if the search query matches any of the fields (name, year, or car type)
        return productName.contains(query.toLowerCase()) ||
            productYear.contains(query.toLowerCase()) ||
            productCarType.contains(query.toLowerCase());
      }).toList();
    }
    update(); // Notify UI to rebuild
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  goToProductDetails(ProductModel product) {
    Get.toNamed(AppRoute.productDetails, arguments: {'product': product});
  }

  @override
  void onInit() {
    super.onInit();

    getData(); // Fetch data when controller initializes
    searchController = TextEditingController();
  }

  @override
  void onClose() {
    // Clear the search query and reset the search field when leaving the page
    searchQuery = '';
    searchController.clear();
    super.onClose();
  }
}


// getImages() async {
  //   statusRequest = StatusRequest.loading;
  //   update();

  //   try {
  //     var response = await productData.viewImages();
  //     statusRequest = handlingData(response);

  //     if (StatusRequest.success == statusRequest) {
  //       if (response['status'] == "success") {
  //         List imageList = response['data'];

  //         // Assuming each image object contains 'image_id', 'items_id', and 'image_url' from the response
  //         images = imageList.map((e) {
  //           // Add itemsId dynamically or use e['items_id'] if available in the response
  //           return ImageModel(
  //             imageId: e['image_id'],
  //             itemsId: e[
  //                 'items_id'], // Assuming 'items_id' is included in the response
  //             imageUrl: e['image_url']
  //                 .toString(), // Assuming 'image_url' is included in the response
  //           );
  //         }).toList();
  //         print(images);
  //       } else {
  //         print("Error: ${response['message']}");
  //       }
  //     }
  //   } catch (e) {
  //     print("Error fetching data: $e");
  //     statusRequest = StatusRequest.failure;
  //   }

  //   update();
  // }

  // deleteData({required String itemId, required String imageName}) async {
  //   statusRequest = StatusRequest.loading;
  //   update();

  //   try {
  //     var response =
  //         await productData.deleteData({'id': itemId, 'imagename': imageName});
  //     print("Response body: $response");

  //     if (response['status'] == 'success') {
  //       // Try parsing itemId and handle errors gracefully
  //       int parsedItemId = int.parse(itemId); // Attempt to parse itemId as int

  //       allProducts.removeWhere((product) => product.id == parsedItemId);
  //       filteredProducts.removeWhere((product) => product.id == parsedItemId);
  //       // If imageName is empty, treat it as null for removal from images list
  //       if (imageName.isEmpty) {
  //         images.removeWhere((image) => image.itemsId == parsedItemId);
  //       } else {
  //         images.removeWhere((image) {
  //           print(
  //               "Checking image: itemsId=${image.itemsId}, imageUrl=${image.imageUrl}");
  //           return image.itemsId == parsedItemId && image.imageUrl == imageName;
  //         });
  //       }
  //       statusRequest = StatusRequest.success;
  //       update(); // Notify UI about changes
  //     } else {
  //       AppLoaders.errorSnackBar(
  //           title: "Error",
  //           message: response['message'] ?? "Failed to delete product");

  //       statusRequest = StatusRequest.failure;

  //       // Show failure snackbar
  //       AppLoaders.errorSnackBar(
  //           title: "Error", message: "Failed to delete product");
  //     }
  //   } catch (e) {
  //     statusRequest = StatusRequest.failure;
  //     AppLoaders.errorSnackBar(
  //         title: "Error", message: "An error occurred while deleting");
  //     print("Error during deletion: $e");
  //   }

  //   update(); // Notify the UI to rebuild
  // }

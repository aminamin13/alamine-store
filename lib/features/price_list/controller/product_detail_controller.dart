import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/features/price_list/controller/price_list_controller.dart';
import 'package:al_amine_store/features/price_list/data/price_list_view_datasource.dart';
import 'package:al_amine_store/features/products/data/model/image_model.dart';
import 'package:al_amine_store/features/products/data/model/products_model.dart';
import 'package:al_amine_store/features/sales/data/datasource/sales_datasource.dart';
import 'package:al_amine_store/features/sales/data/model/sales_model.dart';
import 'package:al_amine_store/functions/handlingdatacontroller.dart';
import 'package:al_amine_store/loaders/snackbar.dart';
import 'package:al_amine_store/utlis/const/routes.dart';
import 'package:al_amine_store/utlis/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ProductDetailController extends GetxController {}

class ProductDetailControllerImpl extends ProductDetailController {
  static ProductDetailControllerImpl get instance => Get.find();

  ProductModel? productModel;
  List<ProductModel> allProducts = [];
  List<ImageModel> imagesList = [];
  ImageModel? imageModel;
  late StatusRequest statusRequest;
  PriceListViewDatasource productData = PriceListViewDatasource(Get.find());

  SalesDataSource salesDataSource = SalesDataSource(Get.find());
  PriceListControllerImpl priceListControllerImpl = Get.put(
    PriceListControllerImpl(),
  );
  SalesModel? salesModel;

  // Global variable to store matching sale data
  Map<String, dynamic>? matchingSaleData;
  // Or, if you only need itemsId:
  int? globalSaleItemsId;

  late TextEditingController customerNameController;
  late TextEditingController priceController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onReady() {
    super.onReady();
    getImages(productModel!.id.toString());
  }

  searchAndRetrieveSale() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      // Assume salesDataSource.viewData() returns a list of sale records:
      var response = await salesDataSource.viewData();
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success &&
          response['status'] == 'success') {
        // Assume response['data'] is a list of sales
        List salesDataList = response['data'];

        // Filter the list to find the sale record with a matching items_id
        var matchingSale = salesDataList.firstWhere(
          (sale) => sale['items_id'].toString() == productModel!.id.toString(),
          orElse: () => null,
        );

        if (matchingSale != null) {
          String itemsId = matchingSale['items_id'].toString();
          print("Found sale with items_id: $itemsId");

          // Set global variables:
          matchingSaleData = matchingSale;
          globalSaleItemsId = int.parse(itemsId);

          // If your SalesModel accepts additional fields, map them as needed:
          salesModel = SalesModel(
            itemsId: int.parse(itemsId),
            // Map additional fields if required
          );
        } else {
          matchingSaleData = null;
          globalSaleItemsId = null;
          salesModel = null;
        }
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
      matchingSaleData = null;
      globalSaleItemsId = null;
      AppLoaders.errorSnackBar(message: "An error occurred", title: "Error");
      print("Error searching for sale: $e");
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();
    salesModel = SalesModel();
    productModel = Get.arguments['product'];
    customerNameController = TextEditingController();
    priceController = TextEditingController();
    // Search for sale data during initialization
    searchAndRetrieveSale();
    print("Product ID: ${productModel!.id}");
    // This print might be null initially if searchAndRetrieveSale hasn't completed
    print("Global Sale Items ID: $globalSaleItemsId");
  }

  addSales() async {
    var formdata = formKey.currentState;

    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        // Send the product data to the server using postData
        var response = await productData.salesData(
          salesItemCarType: productModel!.carType!,
          salesItemName: productModel!.name!,
          salesItemYear: AppValidator.convertArabicNumbers(
            productModel!.year!.toString(),
          ),
          salesItemLocation: productModel!.location!,
          salesPrice: AppValidator.convertArabicNumbers(priceController.text),
          salesProfit:
              (int.parse(
                        AppValidator.convertArabicNumbers(priceController.text),
                      ) -
                      productModel!.price!)
                  .toString(),
          salesCustomer: customerNameController.text,
          itemsId: productModel!.id.toString(),
          itemCount: (productModel!.itemCount!).toString(),
        );
        statusRequest = handlingData(response);
        if (response['status'] == "success") {
          // Notify the UI and show success message
          salesModel = SalesModel(
            salesItemCarType: productModel!.carType!,
            salesItemName: productModel!.name!,
            salesItemYear: productModel!.year!,
            salesItemLocation: productModel!.location!,
            salesPrice: productModel!.price!,
            salesProfit:
                int.parse(
                  AppValidator.convertArabicNumbers(priceController.text),
                ) -
                productModel!.price!,
            salesCustomer: customerNameController.text,
            itemsId: productModel!.id,
          );

          AppLoaders.successSnackBar(title: "34".tr, message: "93".tr);
          statusRequest = StatusRequest.success;
          Get.offAllNamed(AppRoute.priceListPage);
          update();
        } else {
          statusRequest = StatusRequest.failure;
          AppLoaders.errorSnackBar(message: "94".tr, title: "36".tr);
        }
      } catch (e) {
        print("Error: $e");
        statusRequest = StatusRequest.failure;
        AppLoaders.errorSnackBar(message: "95".tr, title: "36".tr);
      }
    }
  }

  getImages(String itemsId) async {
    statusRequest = StatusRequest.loading;
    update();
    print("Fetching images...");

    try {
      var response = await productData.viewImages(itemsId);
      print("API response: $response");

      statusRequest = handlingData(response);
      print("Handling data result: $statusRequest");

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          List imageList = response['data'];
          print("Raw images data: $imageList");

          imagesList =
              imageList.map<ImageModel>((e) {
                return ImageModel(
                  imageId: e['image_id'],
                  itemsId: e['items_id'],
                  imageUrl: e['image_url'],
                );
              }).toList();
          print("Mapped images list: $imagesList");
        } else {
          print("Error from API: ${response['message']}");
        }
      }
    } catch (e) {
      print("Error fetching images: $e");
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  deleteData({required String itemId, required String imageName}) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await productData.deleteData({
        'id': itemId,
        'imagename': imageName,
      });
      print("Response body: $response");

      if (response['status'] == 'success') {
        int parsedItemId = int.parse(itemId);
        if (productModel != null && productModel!.id == parsedItemId) {
          if (imageName.isNotEmpty) {
            imagesList.removeWhere(
              (image) =>
                  image.itemsId == parsedItemId && image.imageUrl == imageName,
            );
          } else {
            imagesList.removeWhere((image) => image.itemsId == parsedItemId);
          }
          Get.offNamed(AppRoute.priceListPage);
        }
        statusRequest = StatusRequest.success;
      } else {
        AppLoaders.errorSnackBar(
          title: "36".tr,
          message: response['message'] ?? "96".tr,
        );
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
      AppLoaders.errorSnackBar(title: "36".tr, message: "97".tr);
      print("Error during deletion: $e");
    }

    update();
  }

  goToProductEditPage() {
    Get.toNamed(
      AppRoute.editProductDetails,
      arguments: {'product': ProductModel.fromJson(productModel!.toJson())},
    );
  }
}

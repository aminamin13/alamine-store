import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/features/price_list/controller/price_list_controller.dart';
import 'package:al_amine_store/features/price_list/controller/product_detail_controller.dart';
import 'package:al_amine_store/features/price_list/data/price_list_view_datasource.dart';
import 'package:al_amine_store/features/products/data/model/image_model.dart';
import 'package:al_amine_store/features/products/data/model/products_model.dart';
import 'package:al_amine_store/functions/handlingdatacontroller.dart';
import 'package:al_amine_store/loaders/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class EditProductController extends GetxController {}

class EditProductControllerImp extends EditProductController {
  ProductModel? productModel; // Allow it to be null initially

  late TextEditingController carTypeController;
  late TextEditingController carYearController;
  late TextEditingController itemColorController;
  late TextEditingController itemNameController;
  late TextEditingController itemPriceController;
  late TextEditingController itemSellPriceController;
  late TextEditingController noteController;
  late TextEditingController itemCountController;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String selectedValue = "بورة شوكين";
  bool isFileImage = false;

  StatusRequest statusRequest = StatusRequest.none;
  PriceListViewDatasource productData = PriceListViewDatasource(Get.find());
  List<XFile> images = [];
  List<ImageModel> imagesList = [];

  editProduct() async {
    var formdata = formKey.currentState;

    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        // Prepare data to update the product
        Map<String, dynamic> data = {
          "items_id": productModel!.id.toString(),
          "car_type": carTypeController.text,
          "name": itemNameController.text,
          "year": carYearController.text,
          "color": itemColorController.text,
          "location": selectedValue,
          "price": itemPriceController.text,
          "sellprice": itemSellPriceController.text,
          "note": noteController.text,
          "datenow": DateTime.now().toString(),
          "item_count": itemCountController.text
        };

        var response = await productData.editData(data);

        statusRequest = handlingData(response);
        if (StatusRequest.success == statusRequest) {
          if (response['status'] == "success") {
            PriceListControllerImpl priceListControllerImpl =
                Get.find<PriceListControllerImpl>();
            ProductDetailControllerImpl productDetailController =
                Get.find<ProductDetailControllerImpl>();

            productDetailController.productModel = ProductModel(
              id: productModel!.id, // Ensure ID remains unchanged
              name: data["name"],
              price: int.tryParse(data["price"].toString()) ?? 0,
              sellPrice: int.tryParse(data["sellprice"].toString()) ?? 0,
              year: int.tryParse(data["year"].toString()) ?? 0,
              location: data["location"],
              carType: data["car_type"],
              note: data["note"],
              color: data["color"],
              itemCount: int.tryParse(data["item_count"].toString()) ?? 0,

              // Preserve existing stock condition
            );
            AppLoaders.successSnackBar(title: "34".tr, message: "91".tr);
            Get.offAllNamed("/priceList");

            productDetailController.update();
            priceListControllerImpl.getData();
          }
        } else {
          statusRequest = StatusRequest.failure;
        }
      } catch (e) {
        print(e);
        statusRequest = StatusRequest.failure;
        AppLoaders.errorSnackBar(title: "36".tr, message: "92".tr);
      }

      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    productModel = Get.arguments['product'];

    carTypeController =
        TextEditingController(text: productModel?.carType ?? '');
    carYearController =
        TextEditingController(text: productModel?.year.toString() ?? '');
    itemColorController =
        TextEditingController(text: productModel?.color ?? '');
    itemNameController = TextEditingController(text: productModel?.name ?? '');
    itemPriceController =
        TextEditingController(text: productModel?.price.toString() ?? '');
    itemSellPriceController =
        TextEditingController(text: productModel?.sellPrice.toString() ?? '');
    noteController = TextEditingController(text: productModel?.note ?? '');
    selectedValue = productModel?.location ?? "بورة شوكين";
    itemCountController =
        TextEditingController(text: productModel?.itemCount.toString() ?? '');
  }

  @override
  void dispose() {
    super.dispose();
    carTypeController.dispose();
    itemSellPriceController.dispose();
    carYearController.dispose();
    itemColorController.dispose();
    itemNameController.dispose();
    itemPriceController.dispose();
    itemCountController.dispose();
    noteController.dispose();
  }
}

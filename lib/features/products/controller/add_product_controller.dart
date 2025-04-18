import 'dart:io';

import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/features/price_list/controller/price_list_controller.dart';
import 'package:al_amine_store/features/products/data/datasource/remote/add_product_data.dart';
import 'package:al_amine_store/features/products/data/model/image_model.dart';
import 'package:al_amine_store/features/products/data/model/products_model.dart';
import 'package:al_amine_store/functions/handlingdatacontroller.dart';
import 'package:al_amine_store/loaders/snackbar.dart';
import 'package:al_amine_store/utlis/validators/validation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class AddProductController extends GetxController {
  addProduct();
  //deleteMessage(BuildContext context);
  //openBottomSheet(BuildContext context);
  clearFields();
}

class AddProductControllerImp extends AddProductController {
  late TextEditingController carTypeController;
  late TextEditingController carYearController;
  late TextEditingController itemColorController;
  late TextEditingController itemNameController;
  late TextEditingController itemPriceController;
  late TextEditingController itemSellPriceController;
  late TextEditingController noteController;
  late TextEditingController itemCountController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PriceListControllerImpl priceListControllerImpl =
      Get.put(PriceListControllerImpl());

  AddProductData addProductData = AddProductData(Get.find());

  StatusRequest statusRequest = StatusRequest.none;
  late ProductModel product;
  File? image;
  String selectedValue = "بورة شوكين";
  List<XFile> images = [];
  late ImageModel imageModel;
  

  addImages(String id) async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      // Send images to the server
      var response =
          await addProductData.postImagesData(images: images, itemsId: id);

      // Handle the response status
      statusRequest = handlingData(response);
      update(); // Notify UI

      if (statusRequest == StatusRequest.success) {
        print("Images upload success: $response");

        imageModel = ImageModel.fromJson(response["data"]);
        print(imageModel);
        update();
      }
    } catch (e) {
      // Handle any exceptions or errors during the image upload process
      if (kDebugMode) {
        print("Error occurred while adding images: $e");
      }
      statusRequest = StatusRequest.failure;
      update(); // Notify UI
    }
  }

  @override
  @override
  addProduct() async {
    var formdata = formKey.currentState;

    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        // Send the product data to the server using postData

        // Convert Arabic numbers to Western before sending the request
        var response = await addProductData.postData(
          itemCarType: carTypeController.text,
          itemName: itemNameController.text,
          itemYear: AppValidator.convertArabicNumbers(carYearController.text),
          itemColor: itemColorController.text,
          itemLocation: selectedValue,
          itemPrice:
              AppValidator.convertArabicNumbers(itemPriceController.text),
          itemSellPrice:
              AppValidator.convertArabicNumbers(itemSellPriceController.text),
          itemNote: noteController.text,
          itemCount: itemCountController.text,
        );
        statusRequest = handlingData(response);
        // Handling the response
        if (response['status'] == "success") {
          // Check if 'items_id' exists in the response
          var latestId = await addProductData.getLatestItemId();
          print("--------------$latestId");

          // Create the ProductModel with the response data
          product = ProductModel(
            id: int.parse(latestId),
            carType: carTypeController.text,
            name: itemNameController.text,
            year: int.parse(
                AppValidator.convertArabicNumbers(carYearController.text)),
            color: itemColorController.text,
            location: selectedValue,
            price: int.parse(
                AppValidator.convertArabicNumbers(itemPriceController.text)),
            sellPrice: int.parse(AppValidator.convertArabicNumbers(
                itemSellPriceController.text)),
            note: noteController.text,
            itemCount: int.parse(itemCountController.text),
          );

          await addImages(latestId.toString());

          // Notify the UI and show success message
          AppLoaders.successSnackBar(title: "34".tr, message: "35".tr);
          priceListControllerImpl.getData();
          // Clear form fields and images
          clearFields();
          clearImages();
          print("Product Model: ${product.toJson()}");
          statusRequest = StatusRequest.success;

          update();

          // Proceed with uploading images if any
        } else {
          // Handle any other status returned by the API
          statusRequest = StatusRequest.failure;
          AppLoaders.errorSnackBar(message: "37".tr, title: "36".tr);
        }
      } catch (e) {
        print("Error: $e");
        statusRequest = StatusRequest.failure;
        AppLoaders.errorSnackBar(message: "38".tr, title: "36".tr);
      }
    }
  }

  Future<void> pickMultipleImages(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage();

    try {
      if (pickedFiles.isNotEmpty) {
        images.addAll(pickedFiles);

        for (var img in images) {
          print("Image Path: ${img.path}");
        }

        update();
      } else {
        AppLoaders.warningSnackBar(message: "39".tr, title: "40".tr);
      }
    } catch (e) {
      AppLoaders.errorSnackBar(message: "41".tr, title: "36".tr);
    }
    update();
  }

  void deleteImage(int index) {
    images.removeAt(index);
    update();
  }

  void clearImages() {
    images.clear();
    update();
  }

  @override
  // Future<void> pickImage(BuildContext context, ImageSource source) async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? pickedFile = await picker.pickImage(source: source);

  //   try {
  //     if (pickedFile != null) {
  //       image = File(pickedFile.path);
  //       print("Image Path: ${image!.path}");

  //       update();
  //     } else {
  //       AppLoaders.warningSnackBar(
  //           message: "No Image Selected", title: "Warning");
  //     }
  //   } catch (e) {
  //     AppLoaders.errorSnackBar(
  //         message: "Failed to pick image: $e", title: "Error");
  //   }
  //   update();
  // }

  @override
  // Future<dynamic> deleteMessage(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             title: const Text("Delete Image"),
  //             content:
  //                 const Text("Are you sure you want to delete this image?"),
  //             actions: [
  //               TextButton(
  //                 child: const Text("Cancel"),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //               TextButton(
  //                 child: const Text("Delete"),
  //                 onPressed: () {
  //                   image = null;
  //                   update(); // Notify the UI about the change

  //                   Navigator.pop(context);
  //                 },
  //               ),
  //             ],
  //           ));
  // }

  @override
  // Future openBottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return SizedBox(
  //         height: 170,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.only(top: 10.0),
  //               child: Center(
  //                 child: Text("Please choose an option",
  //                     style:
  //                         TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
  //               ),
  //             ),
  //             ListTile(
  //               leading: const Icon(
  //                 Icons.camera_alt,
  //                 color: AppColors.buttonPrimary,
  //               ),
  //               title: const Text("Camera",
  //                   style:
  //                       TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
  //               onTap: () {
  //                 pickImage(context, ImageSource.camera);
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(
  //                 Icons.photo_library,
  //                 color: AppColors.buttonPrimary,
  //               ),
  //               title: const Text("Gallery",
  //                   style:
  //                       TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
  //               onTap: () {
  //                 pickImage(context, ImageSource.gallery);
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  void onInit() {
    carTypeController = TextEditingController();
    carYearController = TextEditingController();
    itemColorController = TextEditingController();
    itemNameController = TextEditingController();
    itemPriceController = TextEditingController();
    itemSellPriceController = TextEditingController();
    noteController = TextEditingController();
    itemCountController = TextEditingController();
    super.onInit();
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
    noteController.dispose();
    itemCountController.dispose();
  }

  @override
  void clearFields() {
    carTypeController.clear();
    itemSellPriceController.clear();
    carYearController.clear();
    itemColorController.clear();
    itemNameController.clear();
    itemPriceController.clear();
    noteController.clear();
    itemCountController.clear();
    image = null;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/colors.dart';
import '../constant/helpers.dart';
import '../models/percentage.dart';

class PercentageController extends GetxController {
  Rx<TextEditingController> percentageController = TextEditingController().obs;
  RxBool loading = false.obs;
  @override
  void onInit(){
    fetchExistingPercentage();
    print(categoryId);

    super.onInit();
  }
  var categoryId;
  Future<void> fetchExistingPercentage() async {
    try {
      var snapshot = await percentageRef.get();

      if (snapshot.docs.isNotEmpty) {
        // If documents are found, extract data from the first document
        var data = snapshot.docs.first.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('percentage')) {
          // Extract the 'percentage' field
          var existingValue = data['percentage'] as String?; // Assuming 'percentage' is a String field
          categoryId = data['id'] as String?; // Assuming 'percentage' is a String field

          if (existingValue != null) {
            // Update the value in your controller or state
            percentageController.value.text = existingValue;
          } else {
            // Handle the case where 'percentage' field is null
            percentageController.value.text = "Default Value";
          }
        } else {
          // Handle the case where 'percentage' field is missing
          percentageController.value.text = "Default Value";
        }
      } else {
        // No existing percentage document found
        print('No existing percentage document found');
      }
    } catch (error) {
      // Handle any errors that occur during fetching
      print('Error fetching existing percentage: $error');
    }
  }
  Future<void> SetPercentage() async {
    loading.value = true;
    String value = percentageController.value.text.trim();
    print(categoryId);
    if (categoryId !=null) {
      await percentageRef.doc(uid).update({"percentage": value}).then((value){
        Get.snackbar("Congratulations", "Successfully updated Service Percentage value",
            backgroundColor: AppColors.appPrimaryColor, colorText: Colors.white);
        loading.value = false;

      }).catchError((error) {
        Get.snackbar("Error", "Failed to update percentage value: $error",
            backgroundColor: Colors.red, colorText: Colors.white);
        loading.value = false;

      });
    } else {
      Percentage percentage = Percentage(id: uid, percentage: value);
      await percentageRef.doc(uid).set(percentage.toMap()).then((_) {
        Get.snackbar("Congratulations", "Successfully set Service Percentage value",
            backgroundColor: AppColors.appPrimaryColor, colorText: Colors.white);
        loading.value = false;
        Get.back();

      }).catchError((error) {
        Get.snackbar("Error", "Failed to set percentage value: $error",
            backgroundColor: Colors.red, colorText: Colors.white);
        loading.value = false;

      });
    }
  }
}

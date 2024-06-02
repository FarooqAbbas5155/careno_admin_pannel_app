import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/policy.dart';

class Field {
  TextEditingController PolicytitleController = TextEditingController();
  TextEditingController PolicydescriptionController = TextEditingController();
}

class PolicyController extends GetxController {
  Rx<TextEditingController> policyController = TextEditingController().obs;
  Rx<TextEditingController> termsAndConditionsController = TextEditingController().obs;
  RxList<Field> fields = RxList<Field>([]);
  String response = "";
  RxBool uploading = false.obs;
  RxBool upDateloading = false.obs;
  RxBool enableAddNew = false.obs;

  Stream<QuerySnapshot>?  policySnapshot;
  RxList<Policy> policy = RxList<Policy>([]);
  final CollectionReference policyCollection = FirebaseFirestore.instance.collection('policy');
  @override
  void onInit() {
    policySnapshot = policyCollection.snapshots();
    policy.bindStream(policySnapshot!.map((event) => event.docs.map((e) => Policy.fromMap(e.data() as Map<String,dynamic>)).toList()));
    super.onInit();
  }
  void addField() {
    fields.add(Field());
  }
  Future<void> saveToFirestorePolicy() async {
    try {
      uploading.value = true;
      for (var field in fields) {
        int id = DateTime.now().millisecondsSinceEpoch;
        Policy newTerms = Policy(
          id:id.toString() , // Use title as ID for simplicity, you might want to generate a unique ID
          title: field.PolicytitleController.text,
          description: field.PolicydescriptionController.text,
        );
        await policyCollection.doc(id.toString()).set(newTerms.toMap()).then((value) {
          response = "success";
          uploading.value = false;
          field.PolicytitleController.clear();
          field.PolicydescriptionController.clear();

        });
      }
      // Optionally, you can perform actions after data is saved successfully.
    } catch (e) {
      // Handle errors here
      print('Error saving data: $e');
      response = e.toString();
      uploading.value = false;

    }
  }
  Future<void> updateField(int index, String updatedTitle, String updatedDescription) async {
    uploading.value = true;
    try {
      // Get the document ID of the field to be updated
      String id = policy[index].id;
      await policyCollection.doc(id).update({"title":updatedTitle,"description":updatedDescription});
      uploading.value = false;
      // Optionally, you can perform actions after data is updated successfully.
    } catch (e) {
      // Handle errors here
      print('Error updating data: $e');
      uploading.value = false;

    }
  }


}

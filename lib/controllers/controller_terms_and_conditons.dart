import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/terms_and_conditons.dart';

class Field {
  TextEditingController TermstitleController = TextEditingController();
  TextEditingController TermsdescriptionController = TextEditingController();
}

class TermsController extends GetxController {
  Rx<TextEditingController> policyController = TextEditingController().obs;
  Rx<TextEditingController> termsAndConditionsController = TextEditingController().obs;
  RxList<Field> fields = RxList<Field>([]);
  String response = "";
  RxBool editTitle = false.obs;
  RxBool editDescription = false.obs;
  RxBool enableAddNew = false.obs;

  Stream<QuerySnapshot>?  termsSnapshot;
  RxList<TermsAndConditons> terms = RxList<TermsAndConditons>([]);

  final CollectionReference termsAndConditionsCollection = FirebaseFirestore.instance.collection('termsAndConditions');
  @override
  void onInit() {
    // existingTermsAndConditions();
termsSnapshot = termsAndConditionsCollection.snapshots();
terms.bindStream(termsSnapshot!.map((event) => event.docs.map((e) => TermsAndConditons.fromMap(e.data() as Map<String,dynamic>)).toList()));
    super.onInit();
  }
  void addField() {
    fields.add(Field());
  }
RxBool uploading = false.obs;
  Future<void> saveToFirestoreTermsAndConditons() async {
    try {
      uploading.value = true;
      for (var field in fields) {
        int id = DateTime.now().millisecondsSinceEpoch;
        TermsAndConditons newTerms = TermsAndConditons(
          id:id.toString() , // Use title as ID for simplicity, you might want to generate a unique ID
          title: field.TermstitleController.text,
          description: field.TermsdescriptionController.text,
        );
        await termsAndConditionsCollection.doc(id.toString()).set(newTerms.toMap()).then((value) {
          response = "success";
          uploading.value = false;
          field.TermstitleController.clear();
          field.TermsdescriptionController.clear();

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
//   Stream<List<TermsAndConditons>> existingTermsAndConditions() {
//     try {
//       return termsAndConditionsCollection.snapshots().map((snapshot) {
//         return snapshot.docs.map((doc) => TermsAndConditons.fromMap(doc.data() as Map<String, dynamic>)).toList();
//       });
//     } catch (e) {
//       print('Error fetching existing data: $e');
//       return Stream.value([]);
//     }
//
// }
//   Future<void> updateField(int index, String id) async {
//     try {
//       var existingTerms = await terms.value.first; // Get existing terms
//       var field = fields[index];
//       TermsAndConditons updatedTerms = existingTerms[index].copyWith(
//         title: field.TermstitleController.text,
//         description: field.TermsdescriptionController.text,
//       );
//       await termsAndConditionsCollection
//           .doc(id)
//           .update(updatedTerms.toMap())
//           .then((value) {
//         response = "success";
//         uploading.value = false;
//       });
//     } catch (e) {
//       print('Error updating data: $e');
//       response = e.toString();
//       uploading.value = false;
//     }
//   }
  Future<void> updateField(int index, String updatedTitle, String updatedDescription) async {
    try {
      // Get the document ID of the field to be updated
      String id = terms[index].id;
      await termsAndConditionsCollection.doc(id).update({"title":updatedTitle,"description":updatedDescription});

      // Optionally, you can perform actions after data is updated successfully.
    } catch (e) {
      // Handle errors here
      print('Error updating data: $e');
    }
  }

}

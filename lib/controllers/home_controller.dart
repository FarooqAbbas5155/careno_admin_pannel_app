import 'dart:typed_data';
import 'package:careno_admin_pannel_app/models/block_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/colors.dart';
import '../constant/fcm.dart';
import '../constant/firebase_utils.dart';
import '../constant/helpers.dart';
import '../models/add_host_vehicle.dart';
import '../models/categories.dart';
import '../models/last_message.dart';
import '../models/promotion_banner.dart';
import '../models/user.dart ';

class HomeController extends GetxController{

  RxList<String> BannerImages = RxList([]);

  // Get DashBoard data.....
RxBool loading = false.obs;
RxString bannerModel = "".obs;
RxString bannerVehicleId = "".obs;
RxList<User> user = RxList<User>([]);
RxList<LastMessage> message = RxList<LastMessage>([]);
RxList<User> Blockuser = RxList<User>([]);
RxList<User> host = RxList<User>([]);
RxList<User> Blockhost = RxList<User>([]);
RxList<User> hostRequest = RxList<User>([]);
RxList<Category> categories = RxList<Category>([]);
RxList<AddHostVehicle> activeVehicle = RxList<AddHostVehicle>([]);
RxList<AddHostVehicle> vehiclesRequest = RxList<AddHostVehicle>([]);
Stream<QuerySnapshot>? userSnapshot;
Stream<QuerySnapshot>? messageSnapshot;
Stream<QuerySnapshot>? BlockuserSnapshot;
Stream<QuerySnapshot>? hostSnapshot;
Stream<QuerySnapshot>? BlockhostSnapshot;
Stream<QuerySnapshot>? HostRequestSnapshot;
Stream<QuerySnapshot>? VehicelRequestSnapshot; // Es Ka variable modelClass maay bnana haay
Stream<QuerySnapshot>?  categorySnapshot;
Stream<QuerySnapshot>?  ActiveVehicleSnapshot;
@override
void onInit(){
  updateToken();
  userSnapshot = usersRef.where("userType", isEqualTo: "user").snapshots();
  user.bindStream(userSnapshot!.map((event) => event.docs.map((e) => User.fromMap(e.data() as Map<String,dynamic>)).toList()));
  BlockuserSnapshot = usersRef.where("userType", isEqualTo: "user").where("isBlocked",isEqualTo: true).snapshots();
  Blockuser.bindStream(BlockuserSnapshot!.map((event) => event.docs.map((e) => User.fromMap(e.data() as Map<String,dynamic>)).toList()));
  hostSnapshot = usersRef.where("userType", isEqualTo: "host").snapshots();
  host.bindStream(hostSnapshot!.map((event) => event.docs.map((e) => User.fromMap(e.data() as Map<String,dynamic>)).toList()));
  BlockhostSnapshot = usersRef.where("userType", isEqualTo: "host").where("isBlocked",isEqualTo: true).snapshots();
  Blockhost.bindStream(BlockhostSnapshot!.map((event) => event.docs.map((e) => User.fromMap(e.data() as Map<String,dynamic>)).toList()));
  HostRequestSnapshot = usersRef.where("userType", isEqualTo: "host").where("isVerified",isEqualTo: false).snapshots();
  hostRequest.bindStream(HostRequestSnapshot!.map((event) => event.docs.map((e) => User.fromMap(e.data() as Map<String,dynamic>)).toList()));
  VehicelRequestSnapshot = addVehicleRef.where("isVerified",isEqualTo: false).where("status",isEqualTo: "Pending").snapshots();
  vehiclesRequest.bindStream(VehicelRequestSnapshot!.map((event) => event.docs.map((e) => AddHostVehicle.fromMap(e.data() as Map<String,dynamic>)).toList() ));
  categorySnapshot = categoryRef.snapshots();
  categories.bindStream(categorySnapshot!.map((event) => event.docs.map((e) => Category.fromMap(e.data() as Map<String,dynamic>)).toList()));
  messageSnapshot =  usersRef.doc(uid).collection("chats").snapshots();
  message.bindStream(messageSnapshot!.map((event) => event.docs.map((e) => LastMessage.fromMap(e.data() as Map<String,dynamic>)).toList()));
  ActiveVehicleSnapshot = addVehicleRef.where("isVerified",isEqualTo:true).where("status",isEqualTo: "Active").snapshots();
  activeVehicle.bindStream(ActiveVehicleSnapshot!.map((event) => event.docs.map((e) => AddHostVehicle.fromMap(e.data() as Map<String,dynamic>)).toList() ));
  super.onInit();

}
RxBool BannerLoding = false.obs;
Future<String> AddPromotionalBanner(String vehicleId,description,List<String> image,)async {
  String response = '';
  BannerLoding.value = true;
 List<String> imageUrl =  await FirebaseUtils.uploadMultipleImage(BannerImages.value,"promotionalBanner/${uid}/", extension: "png");
  PromotionBanner promotionBanner = PromotionBanner(
      vehiceId: vehicleId,
      description: description,
      imageList: imageUrl, vehicleModel: bannerModel.value);

  await bannerRef.doc(uid).set(promotionBanner.toMap()).then((value) {
    response = "success";
    BannerLoding.value = false;
    Get.snackbar("Success", "Promotional Banner Upload",backgroundColor: AppColors.appPrimaryColor,colorText: Colors.white);
    bannerVehicleId.value = "";
    bannerModel.value = "";
  }).catchError((error){
    response = error.toString();
    BannerLoding.value = false;

    print(response);
  });
  return response;
}

  void updateToken() async {
  var token = (await FCM.generateToken()) ?? "";
  usersRef.doc(uid).update({"notificationToken": token});
}
}
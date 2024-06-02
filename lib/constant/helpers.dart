import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../models/categories.dart';
import '../models/user.dart';
import '../view/authentication/screen_login.dart';
import '../view/screens/screen_dashboard.dart';

String image_url = "https://phito.be/wp-content/uploads/2020/01/placeholder.png";

Color primaryColor = Color(0xff4C0AE1);
var uid = auth.FirebaseAuth.instance.currentUser!.uid;
var dbInstance = FirebaseFirestore.instance;
CollectionReference usersRef = dbInstance.collection("users");
CollectionReference categoryRef = dbInstance.collection("categories");
CollectionReference addVehicleRef = dbInstance.collection("vehicles");
CollectionReference bookingsRef = dbInstance.collection("bookings");
CollectionReference percentageRef = dbInstance.collection("percentage");
CollectionReference notificationRef = dbInstance.collection("notifications");
CollectionReference bannerRef = dbInstance.collection("promotionalBanner");
CollectionReference blcokUserRef = dbInstance.collection("block");

Map<String, User> _allUsersMap = {};
Map<String, Category> _allCategoryMap = {};

Future<User> getUser(String id)async{
  var user = _allUsersMap[id];
 if (user == null) {
   var doc = await usersRef.doc(id).get();
   user = User.fromMap(doc.data() as Map<String,dynamic>);
   _allUsersMap[id] = user;

 }

  return user;
}
User defaultUser = User(
  userType: "",
  phoneNumber: "phoneNumber",
  imageUrl: "",
  name: '',
  email: '',
  profileDescription: '',
  dob: 0,
  lat: 0.0,
  lng: 0.0,
  uid: uid,
  gender: "",
  notification: false,
  notificationToken: '',
  timeStamp: DateTime.now().millisecondsSinceEpoch,
  isVerified: false,
  isBlocked: false,
  status: '', address: '', currentBalance: 0.0,
);
bool status  = false;
Future<bool> checkBlockUser(String userId)async{
  DocumentSnapshot userSnapshot = await blcokUserRef.doc(userId).get();
  status =  userSnapshot.exists;
  return status;
}
Future<Category> getCategory(String id) async {
  var category = _allCategoryMap[id];
  if (category == null) {
    var doc = await categoryRef.doc(id).get();
    category = Category.fromMap(doc.data() as Map<String, dynamic>);
    _allCategoryMap[id] = category;
  }
  return category;
}

String dateFormat(DateTime dateTime,) {
  // Use DateFormat class from intl package to format the date
  DateFormat dateFormat = DateFormat.yMMMMd('en_US');
  return dateFormat.format(dateTime);
}
String get2ndUserId(String chatRoomId, String myId){
  return chatRoomId.replaceAll(myId, "").replaceAll("_", "").trim();
}
String BookingDateFormate(int dateTime){
  DateTime dobDateTime = DateTime.fromMillisecondsSinceEpoch(dateTime);
  String formattedDate = DateFormat('dd/MM/yyyy ').format(dobDateTime);
  return formattedDate;
}
String formatTime(int hour24) {

  // Create a DateTime object with the given hour in 24-hour format
  DateTime dateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hour24);

  // Format the DateTime object using DateFormat to convert to 12-hour format with AM/PM
  DateFormat dateFormat = DateFormat('h:mm a'); // 'h:mm a' for 12-hour format with AM/PM
  String formattedTime = dateFormat.format(dateTime);

  return formattedTime;
}
Future<void> deleteDirectory(String path) async {
  try {
    // Get reference to the directory
    Reference directoryRef = FirebaseStorage.instance.ref().child(path);

    // List all items (files and subdirectories) in the directory
    ListResult result = await directoryRef.listAll();

    // Delete each item (file or subdirectory) recursively
    for (Reference ref in result.items) {
      if (ref.fullPath.endsWith('/')) {
        // If the item is a subdirectory (ends with '/'), delete it recursively
        await deleteDirectory(ref.fullPath);
      } else {
        // If the item is a file, delete it
        await ref.delete();
      }
    }

    // After deleting all items, delete the directory itself
    await directoryRef.delete();

    print('Directory $path and its contents deleted successfully.');
  } catch (e) {
    print('Error deleting directory $path: $e');
  }
}
Future<Widget> getHomeScreen() async {
  Widget screen = ScreenLogin();
  // if (auth.FirebaseAuth.instance.currentUser != null) {
  //   screen = ScreenDashboard();
  //
  // }
  // else {
  //   screen = ScreenLogin();
  // }

  return screen;
}
Future<FilePickerResult?> PickFile(List<String> type) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowMultiple: true,
    allowedExtensions: type,
  );
  var files = [];
  if (result != null) {
    PlatformFile file = result.files.first;
    print(file.name);
    print(file.bytes);
    print(files);
    print(file.size);
    print(file.extension);
    print(file.path);
  } else {
    Get.snackbar("Alert", "No File Pick");
  }
  return result;
}

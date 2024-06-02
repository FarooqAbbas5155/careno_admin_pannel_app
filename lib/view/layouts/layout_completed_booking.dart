import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/helpers.dart';
import '../../models/add_host_vehicle.dart';
import '../../models/booking.dart';
import '../../widgets/custom_button.dart';
import '../screens/screen_vehicle_booked_details.dart';

class LayoutCompletedBooking extends StatelessWidget {
List<Booking> filteredBookings;
Rx<AddHostVehicle?> vehicle = Rx<AddHostVehicle?>(null);

  @override
  Widget build(BuildContext context) {
    filteredBookings=filteredBookings.where((element) => element.bookingStatus=="Completed").toList();
    return filteredBookings.isNotEmpty?
    ListView.builder(
      shrinkWrap: true,
      itemCount: filteredBookings.length,
      itemBuilder: (BuildContext context, int index) {
        var booking = filteredBookings[index];
        return GestureDetector(
          onTap: () {
            Get.to(() => ScreenVehicleBookedDetails(
              booking: booking,
              vehicle: vehicle.value!,
            ));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 14.h),
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                FutureBuilder<DocumentSnapshot>(
                  future: addVehicleRef.doc(booking.vehicleId).get(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.hasError) {
                      return Text("Error loading vehicle data");
                    }
                    vehicle.value = AddHostVehicle.fromMap(snapshot.data!.data() as Map<String, dynamic>);
                    return vehicle.value != null
                        ? CircleAvatar(
                      radius: 25.r,
                      backgroundImage: NetworkImage(vehicle.value!.vehicleImageComplete),
                    ).paddingSymmetric(horizontal: 10.w)
                        : Text("Loading");
                  },
                ),
                Expanded(
                  child: FutureBuilder<DocumentSnapshot>(
                    future: addVehicleRef.doc(booking.vehicleId).get(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      if (!snapshot.hasData || snapshot.hasError) {
                        return Text("Error loading vehicle data");
                      }
                      AddHostVehicle? vehicleData = AddHostVehicle.fromMap(snapshot.data!.data() as Map<String, dynamic>);
                      return vehicleData != null
                          ? Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(vehicleData.vehicleModel).paddingSymmetric(horizontal: 20.w),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(booking.bookingType),
                                    Text("\$ ${booking.price}",style: TextStyle(color: AppColors.appPrimaryColor),),
                                    Text(booking.bookingStatus),
                                  ],
                                ).marginOnly(right: 10.w)
                            ),
                          ],
                        ),
                      )
                          : Text("Loading");
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ):Center(child: Text("No Completed Booking yet",style: TextStyle(color: AppColors.appPrimaryColor,fontFamily: "Nunito",fontSize: 20.sp),),);
  }

LayoutCompletedBooking({
    required this.filteredBookings,
  });
}

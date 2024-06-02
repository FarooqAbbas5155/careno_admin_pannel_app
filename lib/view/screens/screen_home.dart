import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/colors.dart';
import '../../widgets/sidebar_card.dart';
import '../../widgets/sidebar_controller.dart';


class ScreenMobileHomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SidebarController());

    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: AppColors.appPrimaryColor,
        centerTitle: true,
        title: Image.asset("assets/images/careno.png",height: 40,fit: BoxFit.cover,),
      ),
      body: Obx(() {
        return controller.screen[controller.index];
      }),
      drawer: Obx(() {
        return Container(
            width:Get.width*.45,

            child:Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child:Image.asset("assets/images/careno.png"),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        controller.item.length,
                            (index) =>
                            SideCard(
                              isActive: index == controller.index,
                              onPress: () {
                                controller.setIndex = index;
                                Get.back();
                              },
                              sidebar: controller.item[index],
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            decoration:BoxDecoration(
                color:AppColors.appPrimaryColor
            )

        );
      }),
    );
  }
}

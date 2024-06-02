import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/sidebar_card.dart';
import '../../widgets/sidebar_controller.dart';

class ScreenWebHomePage extends StatelessWidget {
  const ScreenWebHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SidebarController());
    return Scaffold(


        body: SafeArea(
          child: Row(
            children: [

              Expanded(
                flex: 2,
                child: SidebarCard(controller: controller),
              ),
              Container(
                height: Get.height,
                width: .5,
                color: Color(0xff35373E),
              ),
              Obx(() {
                return Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Expanded(child: controller.screen[controller.index])
                      ],
                    ));
              }),
            ],
          ),

        )
    );
  }
}

import 'package:careno_admin_pannel_app/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constant/colors.dart';
import 'sidebar_controller.dart';

class SidebarCard extends StatelessWidget {
  SidebarCard({Key? key, required this.controller}) : super(key: key);

  final SidebarController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.appPrimaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child:Image.asset("assets/images/careno.png"),
          ),
          Expanded(
            child: Obx(() {
              return SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    controller.item.length,
                    (index) => SideCard(
                      isActive: index == controller.index,
                      onPress: () {
                        controller.setIndex = index;
                      },
                      sidebar: controller.item[index],
                    ),
                  ),
                ),
              );
            }),
          ),

        ],
      ),
    );
  }
}

class SideCard extends StatefulWidget {
  const SideCard({
    Key? key,
    required this.sidebar,
    required this.isActive,
    required this.onPress,
  }) : super(key: key);
  final Sidebar sidebar;
  final bool isActive;
  final onPress;

  @override
  State<SideCard> createState() => _SideCardState();
}

class _SideCardState extends State<SideCard> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPress,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        padding: EdgeInsets.all(5),
        // margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.horizontal(right: Radius.circular(6)),
          color: widget.isActive?Colors.white:Colors.transparent
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              widget.sidebar.icon,
              // width: 20,
              color: widget.isActive ? AppColors.appPrimaryColor:Colors.white,
            ),
            SizedBox(width: Get.width * 0.01),
            Expanded(
              child: Text(
                widget.sidebar.title,
                maxLines: 1,

                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: widget.isActive ?AppColors.appPrimaryColor: Colors.white,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  fontSize: widget.sidebar.fontSize
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

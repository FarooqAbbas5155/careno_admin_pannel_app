import 'package:careno_admin_pannel_app/widgets/sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../view/layouts/layout_active_vehicles.dart';
import '../view/layouts/layout_categories_list.dart';
import '../view/layouts/layout_customers_list.dart';
import '../view/layouts/layout_dashboard.dart';
import '../view/layouts/layout_logout.dart';
import '../view/layouts/layout_messages.dart';
import '../view/layouts/layout_payout.dart';
import '../view/layouts/layout_privacy_policy.dart';
import '../view/layouts/layout_promotional_banner.dart';
import '../view/layouts/layout_providers_list.dart';
import '../view/layouts/layout_providers_requests.dart';
import '../view/layouts/layout_settings.dart';
import '../view/layouts/layout_terms_and_conditions.dart';
import '../view/layouts/layout_vehicles_requests.dart';


class SidebarController extends GetxController{
  HomeController controller = Get.put(HomeController());

  void onInit() {
    print(controller.user.value.length);
    controller.update();
    super.onInit();

  }
    RxInt _index = 0.obs;

  int get index => _index.value;

  set setIndex(int index) => _index.value = index;

  List<Sidebar> get item => [
    Sidebar(icon: "assets/icons/dashboard.svg", title: "Dashboard",fontSize: 16),
    Sidebar(icon: "assets/icons/category.svg", title: "Category",fontSize: 16),
    Sidebar(icon: "assets/icons/customer.svg", title: "Customer List",fontSize: 16),
    Sidebar(icon: "assets/icons/provider.svg", title: "Provider List",fontSize: 16),
    Sidebar(icon: "assets/icons/providerRequest.svg", title: "Provider Request",fontSize: 14),
    Sidebar(icon: "assets/icons/vehicleRequest.svg", title: "Vehicle Request",fontSize: 14),
    Sidebar(icon: "assets/icons/activeVehicel.svg", title: "Active Vehicle",fontSize: 14),
    Sidebar(icon: "assets/icons/banner.svg", title: "Promotional Banner",fontSize: 14),
    Sidebar(icon: "assets/icons/setting.svg", title: "Settings",fontSize: 14),
    Sidebar(icon: "assets/icons/message.svg", title: "Message",fontSize: 14,),
    Sidebar(icon: "assets/icons/payout.svg", title: "Payout",fontSize: 14,),
    Sidebar(icon: "assets/icons/policy.svg", title: "Privacy Policy",fontSize: 14,),
    Sidebar(icon: "assets/icons/terms.svg", title: "Terms And Conditions",fontSize: 14,),
    Sidebar(icon: "assets/icons/logout.svg", title: "Logout",fontSize: 16),
  ];

  List<Widget> get screen => [
    //  Layouts name call here

    LayoutDashboard(),
    LayoutCategoriesList(),
    LayoutCustomersList(),
    LayoutProvidersList(),
    LayoutProvidersRequests(),
    LayoutVehiclesRequests(),
    LayoutActiveVehicles(),
    LayoutPromotionalBanner(),
    LayoutSettings(),
    LayoutMessages(),
    LayoutPayout(),
    LayoutPrivacyPolicy(),
    LayoutTermsAndConditions(),
    LayoutLogout(),

  ];
}
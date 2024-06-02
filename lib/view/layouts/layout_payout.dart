import 'package:careno_admin_pannel_app/view/layouts/layout_bank.dart';
import 'package:careno_admin_pannel_app/view/layouts/layout_m_pesa.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/helpers.dart';
import '../../constant/my_helper_by_callofcoding.dart';
import '../../controllers/payment_controller.dart';
import '../../models/withdraw_request_model.dart';
import '../../widgets/custom_button.dart';

class LayoutPayout extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Text(
              "WithDraw Request",
              style: TextStyle(
                  color: AppColors.appPrimaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 24.sp,
                  fontFamily: "Nunito"
              ),
            ).marginSymmetric(vertical: 10.h),
            TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              indicator: BoxDecoration(
                color: AppColors.appPrimaryColor,
                borderRadius: BorderRadius.circular(25.0),
              ),
              tabs: [
                Tab(text: "Bank Request"),
                Tab(text: "M-Pesa Request"),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: getWithdrawStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: AppColors.appPrimaryColor,
                      ),
                    );
                  }

                  if (snapshot.hasData && !snapshot.hasError) {
                    List<WithdrawRequestModel> withdrawByMpesa = snapshot.data!.docs
                        .map((e) => WithdrawRequestModel.fromMap(e.data()))
                        .where((element) => element.paymentMethod == 'M-pesa')
                        .toList();
                    List<WithdrawRequestModel> withdrawByBank = snapshot.data!.docs
                        .map((e) => WithdrawRequestModel.fromMap(e.data()))
                        .where((element) => element.paymentMethod == 'Bank Transfer')
                        .toList();

                    print('--------$withdrawByBank \n mpesa$withdrawByMpesa');
                    return TabBarView(
                      children: [
                        LayoutBank(bankRequest: withdrawByBank),
                        LayoutMPesa(mpesa: withdrawByMpesa),
                      ],
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Something went wrong.. ${snapshot.error}',
                        style: AppColors.headingStyle,
                      ),
                    );
                  }

                  return Container(color: Colors.red);
                },
              ),
            ),
          ],
        ).marginSymmetric(horizontal: 10.w),
      ),
    );
  }
}

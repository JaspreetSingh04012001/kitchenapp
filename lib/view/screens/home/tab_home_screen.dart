import 'package:efood_kitchen/controller/auth_controller.dart';
import 'package:efood_kitchen/controller/order_controller.dart';
import 'package:efood_kitchen/controller/theme_controller.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/util/images.dart';
import 'package:efood_kitchen/view/base/animated_dialog.dart';
import 'package:efood_kitchen/view/base/custom_app_bar.dart';
import 'package:efood_kitchen/view/base/custom_rounded_button.dart';
import 'package:efood_kitchen/view/base/logout_dialog.dart';
import 'package:efood_kitchen/view/screens/auth/login_screen.dart';
import 'package:efood_kitchen/view/screens/home/widget/order_status_tabs_item.dart';
import 'package:efood_kitchen/view/screens/home/widget/profile_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/order_list_view.dart';

class TabHomeScreen extends StatefulWidget {
  final TextEditingController searchEditController;
  final TabController? tabController;

  const TabHomeScreen(
      {super.key, required this.searchEditController, this.tabController});
  @override
  State<TabHomeScreen> createState() => _TabHomeScreenState();
}

class _TabHomeScreenState extends State<TabHomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Column(
        children: [
          const CustomAppBar(
            showCart: true,
            isBackButtonExist: true,
            onBackPressed: null,
            icon: '',
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  height: double.infinity,
                  width: 100,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: OrderStatusTabs.values.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return GetBuilder<OrderController>(
                                  builder: (controller) {
                                return InkWell(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: BookingStatusTabItem(
                                      title: OrderStatusTabs.values
                                          .elementAt(index)
                                          .name,
                                    ),
                                  ),
                                  onTap: () {
                                    if (widget.searchEditController.text
                                        .trim()
                                        .isNotEmpty) {
                                      widget.searchEditController.clear();
                                    }
                                    Get.find<OrderController>()
                                        .updateOrderStatusTabs(OrderStatusTabs
                                            .values
                                            .elementAt(index));
                                    if (OrderStatusTabs.values
                                            .elementAt(index)
                                            .name ==
                                        'all') {
                                      Get.find<OrderController>()
                                          .getOrderList(1);
                                    } else {
                                      Get.find<OrderController>().filterOrder(
                                          OrderStatusTabs.values
                                              .elementAt(index)
                                              .name,
                                          1);
                                    }
                                  },
                                );
                              });
                            }),
                      ),
                      // OrderStatusTabBar(
                      //     searchTextController: widget.searchEditController),
                      //const SizedBox.expand(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomRoundedButton(
                          image: Images.logOut,
                          onTap: () {
                            showAnimatedDialog(
                                context: context,
                                barrierDismissible: true,
                                animationType:
                                    DialogTransitionType.slideFromBottomFade,
                                builder: (BuildContext context) {
                                  return CustomLogOutDialog(
                                    icon: Icons.exit_to_app_rounded,
                                    title: 'logout'.tr,
                                    description:
                                        'do_you_want_to_logout_from_this_account'
                                            .tr,
                                    onTapFalse: () =>
                                        Navigator.of(context).pop(false),
                                    onTapTrue: () {
                                      Get.find<AuthController>()
                                          .clearSharedData()
                                          .then((condition) {
                                        Navigator.pop(context);
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginScreen()),
                                                (route) => false);
                                      });
                                    },
                                    onTapTrueText: 'yes'.tr,
                                    onTapFalseText: 'no'.tr,
                                  );
                                });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomRoundedButton(
                          image: Images.themeIcon,
                          onTap: () =>
                              Get.find<ThemeController>().toggleTheme(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomRoundedButton(
                          image: '',
                          onTap: () {
                            showAnimatedDialog(
                                context: context,
                                barrierDismissible: true,
                                animationType:
                                    DialogTransitionType.slideFromBottomFade,
                                builder: (BuildContext context) {
                                  return Dialog(
                                      insetAnimationDuration:
                                          const Duration(milliseconds: 400),
                                      insetAnimationCurve: Curves.easeIn,
                                      elevation: 10,
                                      backgroundColor:
                                          Theme.of(context).cardColor,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(Dimensions
                                                  .paddingSizeDefault))),
                                      child: const SizedBox(
                                          width: 300, child: ProfileDialog()));
                                });
                          },
                          widget: Icon(Icons.person,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: OrderListView(tabController: widget.tabController!),
                ),
              ],
            ),
          ),
          // Positioned.fill(
          //     child: Align(
          //         alignment: Alignment.bottomCenter,
          //         child: Padding(
          //           padding: EdgeInsets.all(
          //             ResponsiveHelper.isSmallTab()
          //                 ? Dimensions.paddingSizeSmall
          //                 : Dimensions.paddingSizeDefault,
          //           ),
          //           child:
          //         ))),
        ],
      );
    });
  }
}

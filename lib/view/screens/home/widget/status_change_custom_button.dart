import 'package:efood_kitchen/controller/order_controller.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusChangeCustomButton extends StatelessWidget {
  GestureTapCallback? onTap;
  bool pop;
  final int orderId;
  final String orderStatus;
  late SharedPreferences prefs;
  StatusChangeCustomButton(
      {Key? key,
      required this.orderId,
      required this.orderStatus,
      this.onTap,
      this.pop = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Get.find<OrderController>().orderStatus == 'confirmed' ||
            orderStatus == 'confirmed'
        ? InkWell(
            onTap: onTap ??
                () async {
                  prefs = await SharedPreferences.getInstance();
                  prefs.remove('$orderId');
                  // Get.find<OrderController>()
                  //     .updateOrderStatusTabs(OrderStatusTabs.all);
                  Get.find<OrderController>()
                      .orderStatusUpdate(orderId, 'cooking');
                  Get.find<OrderController>()
                      .setOrderIdForOrderDetails(orderId, 'cooking', '');
                  Get.find<OrderController>().updateOrderStatusTabs(
                      OrderStatusTabs.values.elementAt(0));
                  Get.find<OrderController>().getOrderList(1);
                  // for (var order in Get.find<OrderController>().orderList!) {
                  //   if (order.id == orderId) {
                  //     print("Iski maa ka bhosda");
                  //     gridBoxKeys[
                  //             Get.find<OrderController>().orderList!.indexOf(order)]
                  //         .currentState!
                  //         .getOrderDetails(orderId);
                  //   }
                  // }
                  if (pop) {
                    Navigator.of(context).pop();
                  } else {
                    // Get.find<AuthController>().getProfile();
                    // Get.offNamed(RouteHelper.home);
                    //   Get.offAll(const HomeScreen());
                  }
                },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              height: 30,
              //  padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.paddingSizeSmall),
                border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(.5)),
                color: Theme.of(context).cardColor,
              ),
              child: Text('start_cooking'.tr,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimensions.fontSizeOverLarge,
                      fontWeight: FontWeight.w400)),
              // Transform.rotate(
              //   angle: Get.find<LocalizationController>().isLtr ? pi * 2 : pi, // in radians
              //   child: Directionality(
              //     textDirection: TextDirection.ltr,
              //     child: SliderButton(
              //       width: ResponsiveHelper.isSmallTab() ? 200 : ResponsiveHelper.isTab(context) ? 300 :  Get.width - 20,

              //       dismissible: false,
              //       action: () {
              //         Get.find<OrderController>().updateOrderStatusTabs(OrderStatusTabs.cooking);
              //         Get.find<OrderController>().orderStatusUpdate(orderId, 'cooking');
              //         Get.find<OrderController>().setOrderIdForOrderDetails(orderId, 'cooking','');
              //         Get.find<OrderController>().getOrderDetails(orderId);
              //       },

              //       label: Text('start_cooking'.tr,
              //         style: Theme.of(context).textTheme.titleLarge!.copyWith(
              //           color: Theme.of(context).primaryColor,
              //           fontSize: Dimensions.fontSizeDefault,
              //         )),
              //       dismissThresholds: 0.5,
              //       icon: Center(child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Image.asset(Images.arrowButton),
              //       )),

              //       radius: 10,

              //       boxShadow: const BoxShadow(blurRadius: 0.0),
              //       buttonColor: Theme.of(context).primaryColor,
              //       backgroundColor: Theme.of(context).cardColor,
              //       baseColor: Theme.of(context).primaryColor,
              //     ),
              //   ),
              // ),
            ),
          )
        : Get.find<OrderController>().orderStatus == 'cooking' ||
                orderStatus == 'cooking'
            ? InkWell(
                onTap: onTap ??
                    () async {
                      prefs = await SharedPreferences.getInstance();
                      prefs.remove('$orderId');
                      Get.find<OrderController>()
                          .updateOrderStatusTabs(OrderStatusTabs.done);
                      Get.find<OrderController>()
                          .orderStatusUpdate(orderId, 'done');
                      Get.find<OrderController>()
                          .setOrderIdForOrderDetails(orderId, 'done', '');
                      Get.find<OrderController>().getOrderDetails(orderId);
                      if (pop) Navigator.of(context).pop();
                    },
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  // padding: const EdgeInsets.symmetric(
                  //     vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.paddingSizeSmall),
                    border: Border.all(
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(.5)),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Text("done".tr,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontSize: Dimensions.fontSizeOverLarge)),
                  // Transform.rotate(
                  //   angle: Get.find<LocalizationController>().isLtr
                  //       ? pi * 2
                  //       : pi, // in radians
                  //   child: Directionality(
                  //     textDirection: TextDirection.ltr,
                  //     child: SliderButton(
                  //       width: ResponsiveHelper.isSmallTab()
                  //           ? 200
                  //           : ResponsiveHelper.isTab(context)
                  //               ? 300
                  //               : Get.width - 20,
                  //       dismissible: false,
                  //       action: () {
                  //         Get.find<OrderController>()
                  //             .updateOrderStatusTabs(OrderStatusTabs.done);
                  //         Get.find<OrderController>()
                  //             .orderStatusUpdate(orderId, 'done');
                  //         Get.find<OrderController>()
                  //             .setOrderIdForOrderDetails(orderId, 'done', '');
                  //         Get.find<OrderController>().getOrderDetails(orderId);
                  //       },
                  //       label: Text('done_cooking'.tr,
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .titleLarge!
                  //               .copyWith(
                  //                 color: Theme.of(context).secondaryHeaderColor,
                  //                 fontSize: Dimensions.fontSizeDefault,
                  //               )),
                  //       dismissThresholds: 0.5,
                  //       icon: Center(
                  //           child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Image.asset(Images.arrowButton),
                  //       )),
                  //       radius: 10,
                  //       boxShadow: const BoxShadow(blurRadius: 0.0),
                  //       buttonColor: Theme.of(context).secondaryHeaderColor,
                  //       backgroundColor: Theme.of(context).cardColor,
                  //       baseColor: Theme.of(context).secondaryHeaderColor,
                  //     ),
                  //   ),
                  // ),
                ),
              )
            : const SizedBox.shrink();
  }
}

import 'dart:async';

import 'package:efood_kitchen/controller/order_controller.dart';
import 'package:efood_kitchen/data/model/response/order_model.dart';
import 'package:efood_kitchen/helper/responsive_helper.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/util/styles.dart';
import 'package:efood_kitchen/view/screens/home/widget/status_change_custom_button.dart';
import 'package:efood_kitchen/view/screens/order/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controller/splash_controller.dart';
import '../../../../data/model/response/config_model.dart';
import '../../../../data/model/response/order_details_model.dart';
import '../../../../data/repository/order_repo.dart';
import '../../../../util/images.dart';
import '../../../base/animated_dialog.dart';
import '../../../base/custom_divider.dart';

class OrderCardWidget extends StatefulWidget {
  Orders order;
  OrderCardWidget({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderCardWidget> createState() => OrderCardWidgetState();
}

class OrderCardWidgetState extends State<OrderCardWidget> {
  bool isLoading = true;
  String removeEmptyLines(String input) {
    return input
        .replaceAll(RegExp(r'^\s*$\n', multiLine: true), '')
        .split('\n')
        .map((line) => line.trimLeft())
        .join('\n');
  }

  Color? timeColor;
  String _printDuration(Duration duration) {
    if (duration.inHours > 1) {
      timeColor = Colors.red;
    } else {
      if (duration.inMinutes > 6) {
        timeColor = Colors.orange;
      }
      if (duration.inMinutes > 10) {
        timeColor = Colors.red;
      }
    }

    // String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "${duration.inHours > 0 ? duration.inHours : ""} $twoDigitMinutes:$twoDigitSeconds";
  }

  String xyz(timeString) {
    final dateTime = DateTime.parse(timeString);

    // Convert to 12-hour format with date
    final formatter = DateFormat('yyyy-MM-dd h:m a');
    final formattedTime = formatter.format(dateTime);

    // Print the formatted time
    return formattedTime;
  }

  String xyzz(timeString) {
    final dateTime = DateTime.parse(timeString);

    // Convert to 12-hour format with date
    final formatter = DateFormat('yyyy-MM-dd HH mm ss');
    final formattedTime = formatter.format(dateTime);

    // Print the formatted time
    return formattedTime;
  }

  String? timeElapsed;
  caltimeElapsed(String input) {
    setState(() {
      timeElapsed = _printDuration(
          DateTime.now().difference(DateTime.parse(input.replaceAll("Z", ""))));
    });
  }

  String timeconverter(String input) {
    xyz(input);
    input.indexOf(".");

    return input
        .replaceRange(input.indexOf(".") - 3, input.length, "")
        .replaceAll("T", "  ");
  }

  //String? orderStatus;
  late OrderDetailsModel orderDetailsModel;
  final OrderRepo orderRepo = Get.find();

  getOrderDetails(int orderID) async {
    await Get.find<OrderController>()
        .getOrderDetails(orderID, updateUi: 1)
        .then((value) {
      orderDetailsModel = value;
      // orderStatus = orderDetailsModel.order.orderStatus;

      isLoading = false;
      Get.find<OrderController>().update();
      if (orderDetailsModel.order.orderStatus != 'done') {
        Timer.periodic(const Duration(seconds: 1), (Timer t) {
          caltimeElapsed(widget.order.createdAt!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // OrderDetailsModel j = new OrderDetailsModel();

    final ConfigModel configModel = Get.find<SplashController>().configModel;
    return GetBuilder<OrderController>(initState: (state) {
      getOrderDetails(widget.order.id!);
      //   Logger().i(orderDetailsModel.order.orderStatus);
    }, builder: (orderController) {
      return isLoading
          ? SpinKitChasingDots(
              duration: const Duration(milliseconds: 800),
              color: Theme.of(context).primaryColor,
            )
          : InkWell(
              onTap: () {
                //  Logger().i(orderDetailsModel.details[0].toJson());
                showAnimatedDialog(
                  context: context,
                  duration: const Duration(milliseconds: 200),
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return Dialog(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                          width: ResponsiveHelper.isTab(context)
                              ? MediaQuery.sizeOf(context).width * 0.4
                              : null,
                          child: OrderDetailsScreen(orderId: widget.order.id!)),
                    );
                  },
                  animationType: DialogTransitionType.slideFromBottomFade,
                );
              },
              child: Container(
                  margin:
                      const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  decoration: BoxDecoration(
                      //color: Colors.amber,
                      color: Theme.of(context).cardColor,
                      boxShadow: orderController.orderId == widget.order.id
                          ? [
                              BoxShadow(
                                  color: Theme.of(context).primaryColor,
                                  blurRadius: 2,
                                  spreadRadius: .5,
                                  offset: const Offset(0, 0))
                            ]
                          : [
                              BoxShadow(
                                  color: Get.isDarkMode
                                      ? Colors.grey[900]!
                                      : Colors.grey[300]!,
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 2))
                            ],
                      borderRadius:
                          BorderRadius.circular(Dimensions.paddingSizeSmall)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Expanded(child: OrderDetailsScreen(orderId: order.id ?? 0)),
                      Container(
                        // width: MediaQuery.of(context).size.width/2,
                        decoration: BoxDecoration(
                          // color: Colors.amber,
                          color: timeColor ?? Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.only(
                              topLeft:
                                  Radius.circular(Dimensions.paddingSizeSmall),
                              topRight:
                                  Radius.circular(Dimensions.paddingSizeSmall)),
                          boxShadow: [
                            BoxShadow(
                                color: Get.isDarkMode
                                    ? Colors.grey[900]!
                                    : Colors.grey[100]!,
                                blurRadius: 0,
                                spreadRadius: .5,
                                offset: const Offset(0, 3))
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeExtraSmall,
                          vertical: Dimensions.paddingSizeExtraSmall,
                        ),
                        child: Center(
                          child: Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text:
                                      '${'order_id'.tr} #${widget.order.id}  ${orderDetailsModel.order.customerName != "" ? orderDetailsModel.order.customerName : ""}\n${xyz(widget.order.createdAt!)} ${orderDetailsModel.order.orderStatus} ',
                                  style: robotoMedium.copyWith(
                                    color:
                                        timeColor != null ? Colors.white : null,
                                    fontSize: Dimensions.fontSizeDefault,
                                  )),
                              TextSpan(
                                  text: timeElapsed ?? "",
                                  style: robotoMedium.copyWith(
                                    color:
                                        timeColor != null ? Colors.white : null,
                                    fontSize: Dimensions.fontSizeDefault,
                                  )),
                            ]),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            // height: double.infinity,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                                color: orderDetailsModel.order.orderStatus ==
                                        'confirmed'
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(.15)
                                    : orderDetailsModel.order.orderStatus ==
                                            'cooking'
                                        ? Theme.of(context)
                                            .primaryColor
                                            .withOpacity(.15)
                                        : Theme.of(context)
                                            .secondaryHeaderColor
                                            .withOpacity(.15),
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        Dimensions.paddingSizeSmall),
                                    bottomRight: Radius.circular(
                                        Dimensions.paddingSizeSmall))),
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                    orderDetailsModel.details.length, (index) {
                                  bool takeAway = false;
                                  Details? orderDetails =
                                      orderDetailsModel.details[index];
                                  List<AddOns> addOns =
                                      orderDetails.productDetails == null
                                          ? []
                                          : orderDetails
                                                      .productDetails!.addOns ==
                                                  null
                                              ? []
                                              : orderDetails
                                                  .productDetails!.addOns!;
                                  List<Widget> addOnWidgetList = [];
                                  List<Widget> variationWidgetList = [];
                                  List<int> addQty =
                                      orderDetails.addOnQtys ?? [];
                                  List<int> ids = orderDetails.addOnIds ?? [];
                                  // if (index == 0) {
                                  //   Logger().i(orderDetails.toJson());
                                  // }
                                  void fuckit() async {
                                    if (orderDetails.variations != null &&
                                        orderDetails.variations!.isNotEmpty) {
                                      for (Variation variation
                                          in orderDetails.variations!) {
                                        variation.variationValues
                                            ?.forEach((element) {
                                          if (element.level != "Dine in" &&
                                              element.level != "Take away") {
                                            variationWidgetList.add(Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                    flex: 5,
                                                    child: Text(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      element.level.toString(),
                                                      style: robotoRegular
                                                          .copyWith(
                                                        fontSize: Dimensions
                                                            .fontSizeOverLarge,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge!
                                                            .color!,
                                                      ),
                                                      maxLines: 1,
                                                      // overflow: TextOverflow
                                                      //     .ellipsis,
                                                    )),
                                              ],
                                            ));
                                          } else {
                                            if (element.level == "Take away") {
                                              takeAway = true;
                                            }
                                          }
                                        });
                                      }
                                    }

                                    if (ids.length ==
                                            orderDetails.addOnPrices?.length &&
                                        ids.length ==
                                            orderDetails.addOnQtys?.length) {
                                      for (int j = 0; j < ids.length; j++) {
                                        int id = ids[j];

                                        for (var addOn in addOns) {
                                          if (addOn.id == id) {
                                            addOnWidgetList.add(Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                    flex: 5,
                                                    child: Text(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      addOn.name.toString(),
                                                      style: robotoRegular
                                                          .copyWith(
                                                        fontSize: Dimensions
                                                            .fontSizeOverLarge,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge!
                                                            .color!,
                                                      ),
                                                      maxLines: 1,
                                                      // overflow: TextOverflow
                                                      //     .ellipsis,
                                                    )),
                                                Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  " X ${addQty[j]} ",
                                                  textAlign: TextAlign.center,
                                                  style: robotoRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeOverLarge,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .color!),
                                                ),
                                              ],
                                            ));
                                          }
                                        }
                                      }
                                    }
                                    // Future.delayed(
                                    //         const Duration(seconds: 2))
                                    //     .whenComplete(() {
                                    //   setState(() {});
                                    // });
                                  }

                                  fuckit();

                                  return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                            height:
                                                Dimensions.paddingSizeDefault),
                                        Row(children: [
                                          Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  takeAway
                                                      ? Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                "** Takeaway **",
                                                                style: robotoBold.copyWith(
                                                                    color: Colors
                                                                        .orange,
                                                                    fontSize:
                                                                        Dimensions
                                                                            .fontSizeLarge),
                                                              ),
                                                            ),
                                                            Image.asset(
                                                              height: 30,
                                                              width: 30,
                                                              Images.takeAway,
                                                            ),
                                                          ],
                                                        )
                                                      : Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                "** Eat In **",
                                                                style: robotoBold.copyWith(
                                                                    color: Colors
                                                                        .green,
                                                                    fontSize:
                                                                        Dimensions
                                                                            .fontSizeLarge),
                                                              ),
                                                            ),
                                                            Image.asset(
                                                              height: 30,
                                                              width: 30,
                                                              Images.dineIn,
                                                            ),
                                                          ],
                                                        ),
                                                  // if(_addOnsList.isNotEmpty)
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      // Padding(
                                                      //     padding: const EdgeInsets.only(
                                                      //         top: Dimensions
                                                      //             .paddingSizeExtraSmall),
                                                      //     child: Text(
                                                      //         PriceConverter.convertPrice(context, orderDetailsModel.details[index].price!),
                                                      //         style: robotoRegular.copyWith(color: Theme.of(context).hintColor))),

                                                      if (configModel
                                                              .isVegNonVegActive! &&
                                                          orderDetailsModel
                                                                  .details[
                                                                      index]
                                                                  .productDetails!
                                                                  .productType !=
                                                              null)
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius: const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    Dimensions
                                                                        .radiusSmall)),
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        4.0,
                                                                    vertical:
                                                                        2),
                                                            child: Text(
                                                              '${orderDetailsModel.details[index].productDetails!.productType}'
                                                                  .tr,
                                                              style: robotoRegular
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),

                                                  const SizedBox(
                                                      height: Dimensions
                                                          .paddingSizeDefault),
                                                ]),
                                          ),
                                        ]),
                                        Text(
                                            orderDetailsModel.details[index]
                                                .productDetails!.name!,
                                            style: robotoMedium.copyWith(
                                                fontSize: Dimensions
                                                    .fontSizeOverLarge),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis),
                                        const Gap(5),
                                        if (ids.isNotEmpty)
                                          // Column(
                                          //   children: [
                                          //     Row(
                                          //       children: [
                                          //         Text(
                                          //           "Add on :",
                                          //           style:
                                          //               robotoRegular.copyWith(
                                          //             fontSize: Dimensions
                                          //                 .fontSizeLarge,
                                          //             color: Theme.of(context)
                                          //                 .textTheme
                                          //                 .titleLarge!
                                          //                 .color!,
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ],
                                          // ),
                                          ...addOnWidgetList,
                                        if (variationWidgetList.isNotEmpty)
                                          // Column(
                                          //   children: [
                                          //     Row(
                                          //       children: [
                                          //         Text(
                                          //           "Variations :",
                                          //           style:
                                          //               robotoRegular.copyWith(
                                          //             fontSize: Dimensions
                                          //                 .fontSizeLarge,
                                          //             color: Theme.of(context)
                                          //                 .textTheme
                                          //                 .titleLarge!
                                          //                 .color!,
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ],
                                          // ),
                                          ...variationWidgetList,
                                        if (orderDetailsModel
                                                .details[index].note !=
                                            null)
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("${'note'.tr}: ",
                                                  style: robotoBold.copyWith(
                                                      color: Colors.red,
                                                      fontSize: Dimensions
                                                          .fontSizeLarge)),
                                              Expanded(
                                                child: Text(
                                                    orderDetailsModel
                                                            .details[index]
                                                            .note ??
                                                        "",
                                                    maxLines: 5,
                                                    style: robotoBold.copyWith(
                                                      color: Colors.red,
                                                      fontSize: Dimensions
                                                          .fontSizeLarge,
                                                      overflow:
                                                          TextOverflow.clip,
                                                    )),
                                              )
                                            ],
                                          ),
                                        const Gap(10),
                                        const CustomDivider(
                                          height: .25,
                                        ),
                                        const Gap(10),
                                      ]);
                                }),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 15,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${'note'.tr}: ",
                                style: robotoBold.copyWith(
                                    color: Colors.red,
                                    fontSize: Dimensions.fontSizeLarge)),
                            Expanded(
                              child: Text(orderDetailsModel.order.orderNote,
                                  maxLines: 5,
                                  style: robotoBold.copyWith(
                                    color: Colors.red,
                                    fontSize: Dimensions.fontSizeLarge,
                                    overflow: TextOverflow.clip,
                                  )),
                            )
                          ],
                        ),
                      ),
                      // Expanded(child: OrderDetailsScreen(orderId: order.id ?? 0)),
                      orderDetailsModel == null
                          ? Container()
                          : StatusChangeCustomButton(
                              onTap: ResponsiveHelper.isMobile(context)
                                  ? null
                                  : () async {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      if (orderDetailsModel.order.orderStatus ==
                                          'confirmed') {
                                        Get.find<OrderController>()
                                            .orderStatusUpdate(
                                                widget.order.id as int,
                                                'cooking')
                                            .whenComplete(() {
                                          //    Get.find<OrderController>()
                                          // .setOrderIdForOrderDetails(
                                          //     widget.order.id ?? 0, 'cooking', '');
                                          getOrderDetails(widget.order.id ?? 0);
                                          // setState(() {
                                          //   orderStatus = 'cooking';
                                          // });
                                        });

                                        //  Future.delayed(Du)
                                      }
                                      if (orderDetailsModel.order.orderStatus ==
                                          'cooking') {
                                        Get.find<OrderController>()
                                            .orderStatusUpdate(
                                                widget.order.id as int, 'done')
                                            .whenComplete(() {
                                          Get.find<OrderController>()
                                              .updateOrderStatusTabs(
                                                  OrderStatusTabs.values
                                                      .elementAt(0));
                                          Get.find<OrderController>()
                                              .getOrderList(1);
                                          //  getOrderDetails(widget.order.id ?? 0);
                                        });
                                      }

                                      // getOrderDetails(widget.order.id ?? 0);
                                    },
                              orderId: widget.order.id ?? 0,
                              // widget.order.
                              orderStatus: orderDetailsModel.order.orderStatus
                                  .toString())
                    ],
                  )),
            );
    });
  }
}

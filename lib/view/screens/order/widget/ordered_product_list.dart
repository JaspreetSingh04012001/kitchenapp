import 'package:efood_kitchen/controller/order_controller.dart';
import 'package:efood_kitchen/controller/splash_controller.dart';
import 'package:efood_kitchen/data/model/response/config_model.dart';
import 'package:efood_kitchen/data/model/response/order_details_model.dart';
import 'package:efood_kitchen/helper/responsive_helper.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/util/styles.dart';
import 'package:efood_kitchen/view/base/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../util/images.dart';

class OrderedProductList extends StatelessWidget {
  String removeEmptyLines(String input) {
    return input
        .replaceAll(RegExp(r'^\s*$\n', multiLine: true), '')
        .split('\n')
        .map((line) => line.trimLeft())
        .join('\n');
  }

  String timeconverter(String input) {
    input.indexOf(".");
    return input
        .replaceRange(input.indexOf(".") - 3, input.length, "")
        .replaceAll("T", "  ");
    //  final DateFormat formatter = DateFormat('yyyy-MM-dd');
    // final String formatted = formatter.format(input);
    // print(formatted);
  }

  final OrderController orderController;
  Widget? yo;

  OrderedProductList({Key? key, required this.orderController, this.yo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConfigModel configModel = Get.find<SplashController>().configModel;
    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      child: ListView.builder(
        shrinkWrap: ResponsiveHelper.isMobile(context),
        physics:
            //  ResponsiveHelper.isMobile(context) ?
            // const NeverScrollableScrollPhysics(),
            const AlwaysScrollableScrollPhysics(),
        itemCount: orderController.orderDetails.details.length + 1,
        itemBuilder: (context, index) {
          if (index == orderController.orderDetails.details.length) {
            return yo;
          }

          bool takeAway = false;
          String variationText = '';

          Details? orderDetails = orderController.orderDetails.details[index];
          Logger().i(orderDetails.toJson());
          List<AddOns> addonsData = orderDetails.productDetails == null
              ? []
              : orderDetails.productDetails!.addOns == null
                  ? []
                  : orderDetails.productDetails!.addOns!;
          List<Widget> addOnWidgetList = [];
          List<Widget> variationWidgetList = [];
          List<int> addQty = orderDetails.addOnQtys ?? [];
          List<int> ids = orderDetails.addOnIds ?? [];
          if (orderDetails.variations != null &&
              orderDetails.variations!.isNotEmpty) {
            for (Variation variation in orderDetails.variations!) {
              variation.variationValues?.forEach((element) {
                if (element.level != "Dine in" &&
                    element.level != "Take away") {
                  variationWidgetList.add(Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 5,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            element.level.toString(),
                            style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeOverLarge,
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
          } else if (orderDetails.oldVariations != null &&
              orderDetails.oldVariations!.isNotEmpty) {
            List<String> variationTypes =
                orderDetails.oldVariations![0].type != null
                    ? orderDetails.oldVariations![0].type!.split('-')
                    : [];

            if (variationTypes.length ==
                orderDetails.productDetails?.choiceOptions?.length) {
              int index = 0;
              orderDetails.productDetails?.choiceOptions?.forEach((choice) {
                variationText =
                    '$variationText${(index == 0) ? '' : ',  '}${choice.title} - ${variationTypes[index]}';
                index = index + 1;
              });
            } else {
              variationText = orderDetails.oldVariations?[0].type ?? '';
            }
          }

          for (int j = 0; j < ids.length; j++) {
            int id = ids[j];

            for (AddOns addOn in addonsData) {
              if (addOn.id == id) {
                addOnWidgetList.add(Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 5,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          addOn.name.toString(),
                          style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeOverLarge,
                            color:
                                Theme.of(context).textTheme.titleLarge!.color!,
                          ),
                          maxLines: 1,
                          // overflow: TextOverflow
                          //     .ellipsis,
                        )),
                    Expanded(
                        // flex: 5,
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeExtraSmall),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        "x ${addQty[j]}",
                        textAlign: TextAlign.center,
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeOverLarge,
                            color:
                                Theme.of(context).textTheme.titleLarge!.color!),
                      ),
                    )),
                  ],
                ));
              }
            }
          }
          // if (variationText.contains("Order Type (Take Away)")) {
          //   takeAway = true;
          // }
          // variationText = variationText
          //     .replaceAll("Choose ()", "")
          //     .replaceAll("optiona (", "")
          //     .replaceAll("Order Type (Dining)", "")
          //     .replaceAll("Order Type (Take Away)", "")
          //     .replaceAll("Choose (", "\n")
          //     .replaceAll("Choose One (", "\n")
          //     .replaceAll(")", "")
          //     .replaceAll(",", "\n");
          // variationText = removeEmptyLines(variationText);

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          takeAway
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "** Takeaway **",
                                        style: robotoBold.copyWith(
                                            color: Colors.orange,
                                            fontSize: Dimensions.fontSizeLarge),
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
                                            color: Colors.green,
                                            fontSize: Dimensions.fontSizeLarge),
                                      ),
                                    ),
                                    Image.asset(
                                      height: 30,
                                      width: 30,
                                      Images.dineIn,
                                    ),
                                  ],
                                ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      orderController.orderDetails
                                          .details[index].productDetails!.name!,
                                      style: robotoMedium.copyWith(
                                          fontSize:
                                              Dimensions.fontSizeOverLarge),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis)),
                              // Text(
                              //     orderController
                              //         .orderDetails.details[index].quantity
                              //         .toString(),
                              //     style: robotoRegular.copyWith()),
                              // const SizedBox(
                              //     width: Dimensions.paddingSizeExtraLarge),
                              // Text(
                              //   PriceConverter.convertPrice(
                              //       context,
                              //       (orderController.orderDetails.details[index]
                              //               .price! *
                              //           orderController.orderDetails
                              //               .details[index].quantity!)),
                              //   style: robotoMedium.copyWith(),
                              // ),
                            ],
                          ),
                          const Gap(10),
                          if (addOnWidgetList.isNotEmpty)
                            // Column(
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Text(
                            //           "Add on :",
                            //           style: robotoRegular.copyWith(
                            //             fontSize: Dimensions.fontSizeLarge,
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
                            //           style: robotoRegular.copyWith(
                            //             fontSize: Dimensions.fontSizeLarge,
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
                          if (orderDetails.note != null)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${'note'.tr}: ",
                                    style: robotoBold.copyWith(
                                        color: Colors.red,
                                        fontSize: Dimensions.fontSizeLarge)),
                                Expanded(
                                  child: Text(orderDetails.note ?? "",
                                      maxLines: 5,
                                      style: robotoBold.copyWith(
                                        color: Colors.red,
                                        fontSize: Dimensions.fontSizeLarge,
                                        overflow: TextOverflow.clip,
                                      )),
                                )
                              ],
                            ),

                          // if(_addOnsList.isNotEmpty)

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Padding(
                              //     padding: const EdgeInsets.only(
                              //         top: Dimensions.paddingSizeExtraSmall),
                              //     child: Text(
                              //         PriceConverter.convertPrice(
                              //             context,
                              //             orderController.orderDetails
                              //                 .details[index].price!),
                              //         style: robotoRegular.copyWith(
                              //             color: Theme.of(context).hintColor))),
                              if (configModel.isVegNonVegActive! &&
                                  orderController.orderDetails.details[index]
                                          .productDetails!.productType !=
                                      null)
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                            Dimensions.radiusSmall)),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 2),
                                    child: Text(
                                      '${orderController.orderDetails.details[index].productDetails!.productType}'
                                          .tr,
                                      style: robotoRegular.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: Dimensions.paddingSizeDefault),
                        ]),
                  ),
                ]),
                const Padding(
                  padding: EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                  child: CustomDivider(
                    height: .25,
                  ),
                ),
              ]);
        },
      ),
    );
  }
}

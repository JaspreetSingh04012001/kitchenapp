import 'package:efood_kitchen/controller/order_controller.dart';
import 'package:efood_kitchen/data/model/response/order_model.dart';
import 'package:efood_kitchen/helper/responsive_helper.dart';
import 'package:efood_kitchen/util/dimensions.dart';
import 'package:efood_kitchen/view/base/no_data_screen.dart';
import 'package:efood_kitchen/view/base/order_shimmer.dart';
import 'package:efood_kitchen/view/screens/home/widget/order_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderListView extends StatelessWidget {
  final TabController tabController;

  const OrderListView({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final Key key
    final isMobile =
        (Get.height / Get.width) > 1 && (Get.height / Get.width) < 1.7;
    return RefreshIndicator(
      //key: ,
      color: Theme.of(context).cardColor,
      backgroundColor: Theme.of(context).primaryColor,
      onRefresh: () async {
        tabController.index = 0;
        await Get.find<OrderController>().getOrderList(1);
      },
      child: GetBuilder<OrderController>(
        initState: (state) async {
          // state.controller
        },
        builder: (orderController) {
          if (orderController.currentIndex == 1) {
            SharedPreferences.getInstance().then((value) {
              value.clear();
            });
          }

          List<Orders>? orderList = orderController.orderList;

          return Padding(
            padding: const EdgeInsets.only(
              right: Dimensions.paddingSizeDefault,
              top: Dimensions.paddingSizeDefault,
              left: 0,
            ),
            child: Column(children: [
              orderList != null
                  ? orderList.isNotEmpty
                      ? Expanded(
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            controller: orderController.scrollController,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  ResponsiveHelper.isSmallTab() || isMobile
                                      ? 2
                                      : !ResponsiveHelper.isTab(context)
                                          ? 2
                                          : 3,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              childAspectRatio: ResponsiveHelper.isSmallTab()
                                  ? 0.95
                                  : ResponsiveHelper.isTab(context)
                                      ? 0.95
                                      : 1 / 1.2,
                            ),
                            padding: const EdgeInsets.all(0),
                            itemCount: orderList.length,
                            itemBuilder: (context, index) {
                              return OrderCardWidget(order: orderList[(index)]);
                            },
                          ),
                        )
                      : const NoDataScreen()
                  : const Expanded(child: OrderShimmer()),
              // orderController.isLoading && orderController.orderList != null
              //     ? Center(
              //         child: Padding(
              //         padding: const EdgeInsets.all(Dimensions.iconSize),
              //         child: CircularProgressIndicator(

              //             valueColor: AlwaysStoppedAnimation<Color>(
              //                 Theme.of(context).primaryColor)),
              //       ))
              //     : const SizedBox.shrink(),
            ]),
          );
        },
      ),
    );
  }
}
//order: orderList[index]

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:yodacentral/components/yd_colors.dart';

import 'components/item_tab_bar_omnisearch/components/list_search_chat.dart';
import 'components/item_tab_bar_omnisearch/components/list_search_refinan.dart';
import 'components/item_tab_bar_omnisearch/item_tab_bar_omnisearch.dart';

class TabBarOmniSearch extends StatefulWidget {
  String? strSearch;
  TabBarOmniSearch({this.strSearch});
  // const TabBarOmniSearch({Key? key}) : super(key: key);

  @override
  _TabBarOmniSearchState createState() => _TabBarOmniSearchState();
}

class _TabBarOmniSearchState extends State<TabBarOmniSearch> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SizedBox(
        height: Get.height - 200,
        child: Column(
          children: [
            TabBar(
              unselectedLabelColor: Colors.grey,
              indicatorColor: yd_Color_Primary,
              labelColor: yd_Color_Primary,
              labelStyle: TextStyle(
                color: yd_Color_Primary,
                decorationColor: yd_Color_Primary,
                fontFamily: "pm",
                fontSize: 13,
              ),
              tabs: [
                Tab(text: "Kartu financing"),
                Tab(text: "Kartu refinancing"),
                Tab(text: "Chat"),
              ],
            ),
            SizedBox(
              height: Get.height - 250,
              child: TabBarView(
                children: [
                  ItemTabBarOmnisearch(),
                  ListSearchRefinan(),
                  ListSearchChat()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

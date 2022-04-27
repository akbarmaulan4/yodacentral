import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:yodacentral/controller/controller_Lead_count/controller_lead_count.dart';
import 'package:yodacentral/screens/pages/home/components/card_top.dart';
import 'package:yodacentral/screens/pages/home/components/financing.dart';
import 'package:yodacentral/screens/pages/home/components/refinancing.dart';

import 'components/tabtop.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  ControllerLeadCount controllerLeadCount = Get.put(ControllerLeadCount());

  @override
  void initState() {
    super.initState();
    // controllerLeadCount.getLeadCount();
  }


  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              toolbarHeight: 220,
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Colors.white,
              titleSpacing: 0,
              title: cardTop(context),
              pinned: true,
              floating: true,
              forceElevated: false,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(64),
                child: TabTop(
                  onClick: (i) {
                    setState(() {
                      index = i;
                      log(i.toString());
                    });
                  },
                  index: 0,
                ),
              ),
            ),
          )
        ];
      },
      body: SingleChildScrollView(
        child: index == 0 ? Financing() : Refinancing(),
      ),
    );
  }
}

import 'package:doan_clean_achitec/modules/home/home_screen.dart';
import 'package:doan_clean_achitec/modules/home/widgets/home_header.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/search_bar.dart';
import 'package:flutter/material.dart';

import '../home/widgets/ListDestination.dart';
import '../home/widgets/title_des.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              HomeHeader(
                size: size,
                titleCenter: "Discover",
              ),
              SizedBox(
                height: getSize(16),
              ),
              const SearchBarWidget(
                  hintText: "Search destinations your want to discover"),
              SizedBox(
                height: getSize(32),
              ),
              TitleDes(
                largeTitle: 'Popular Destinations',
                seeAll: 'See All',
                onTap: () => homeController.currentIndex.value = 0,
              ),
              ListDestination(size: size),
            ],
          ),
        ),
      ),
    );
  }
}

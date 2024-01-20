import 'package:beamer/beamer.dart';
import 'package:core/theme/styles.dart';
import 'package:flutter/material.dart';

import '../../../routes/app_route_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: Image.network(
                      "https://media.istockphoto.com/id/1290444763/photo/assorted-of-indian-dish-with-curry-dish-naan-chicken.jpg?s=612x612&w=0&k=20&c=5q09leP6_QnvdUEfsB6KUXDTTBJtl88bEwrDfRVNA0U=",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const Expanded(
                flex: 0,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Menu",
                        style: Styles.h3w700,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Expanded(child: menuWidget("Lunch")),
                    Expanded(child: menuWidget("Dinner")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuWidget(String menuType) {
    return GestureDetector(
      child: Column(
        children: [
          SizedBox(
            height: 160,
            width: 160,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Image.network(
                "https://media.istockphoto.com/id/1290444763/photo/assorted-of-indian-dish-with-curry-dish-naan-chicken.jpg?s=612x612&w=0&k=20&c=5q09leP6_QnvdUEfsB6KUXDTTBJtl88bEwrDfRVNA0U=",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(menuType),
        ],
      ),
      onTap: () {
        context.beamToNamed(AppRouteName.homeMenu);
      },
    );
  }
}

import 'package:black_pearl/presentation/dashboard/profile/widgets/list_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:core/data/menu_item.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<MenuItem> menuList = <MenuItem>[
    MenuItem(
      url:
          "https://5.imimg.com/data5/SELLER/Default/2023/7/327860090/HT/LI/RZ/48567411/restaurant-menu-card-printing-service.jpg",
      title: "Lunch",
    ),
    MenuItem(
      url:
          "https://5.imimg.com/data5/SL/BC/RY/SELLER-54701692/menu-card-printing-service.jpeg",
      title: "Dinner",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          shrinkWrap: true,
          itemCount: menuList.length,
          itemBuilder: (context, index) {
            return ListMenuCard(
              imageURL: menuList[index].url,
              title: menuList[index].title,
            );
          },
        ),
      ),
    );
  }
}

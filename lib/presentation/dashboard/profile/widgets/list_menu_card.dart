import 'package:core/theme/styles.dart';
import 'package:core/widgets/outlined_button_widget.dart';
import 'package:flutter/material.dart';

class ListMenuCard extends StatefulWidget {
  final String imageURL;

  final String title;

  const ListMenuCard({required this.imageURL, required this.title, super.key});

  @override
  State<ListMenuCard> createState() => _ListMenuCardState();
}

class _ListMenuCardState extends State<ListMenuCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(27.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              widget.imageURL,
              fit: BoxFit.fill,
              width: 105.0,
              height: 110.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      widget.title,
                      style: Styles.h3w700,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButtonWidget(onTapEvent: () {}, text: "View"),
                        OutlinedButtonWidget(onTapEvent: () {}, text: "Delete"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

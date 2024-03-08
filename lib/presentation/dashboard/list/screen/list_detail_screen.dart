import 'package:beamer/beamer.dart';
import 'package:core/theme/color_constants.dart';
import 'package:core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class ListDetailScreen extends StatefulWidget {
  final String url;

  const ListDetailScreen({required this.url, super.key});

  @override
  State<ListDetailScreen> createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends State<ListDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        message: "",
        leading: BackButton(
          color: ColorConstants.black,
          onPressed: () {
            Beamer.of(context).beamBack();
          },
        ),
        backgroundColor: ColorConstants.transparent,
        hideAppBar: true,
      ),
      backgroundColor: ColorConstants.antiFlashWhite,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 500,
              width: 400,
              child: Image.network(widget.url),
            ),
          ),
        ),
      ),
    );
  }
}

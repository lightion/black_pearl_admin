import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../theme/color_constants.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String message;
  final Widget? leading;
  final List<Widget>? actionList;
  final bool? centerTitle;
  final bool? hideAppBar;
  final Color? backgroundColor;

  AppBarWidget({
    required this.message,
    this.leading,
    this.actionList,
    this.centerTitle,
    this.hideAppBar,
    this.backgroundColor,
  }) : super(key: Key(message));

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text(
            widget.message,
          ),
          leading: widget.leading ??
              Container(
                margin: const EdgeInsets.only(left: AppConstants.eight),
              ),
          leadingWidth: AppConstants.thirtyFive,
          actions: widget.actionList,
          toolbarHeight: AppConstants.appBarHeight,
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          centerTitle: widget.centerTitle ?? true,
          elevation: widget.hideAppBar ?? false ? 0 : AppConstants.ten,
        )
      ],
    );
  }
}

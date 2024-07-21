import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'base_text_widget.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor("#ffffff"),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(  // Center widget to ensure icon is centered
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.arrow_back_ios, color: Colors.grey.shade700),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

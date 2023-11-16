import 'package:flutter/material.dart';
import 'package:use_case_manager/components/color_scheme.dart';

AppBar ucmAppBar(double curWwidth) => AppBar(
      title: const Text(
        "Use Case Manager",
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: UCMColorScheme.white),
      ),
      leading: Builder(builder: (context) {
        return Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: UCMColorScheme.roseRed,
          ),
          child: IconButton(
            icon: const Icon(Icons.menu_rounded),
            color: UCMColorScheme.darkGray,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        );
      }),
      centerTitle: true,
      backgroundColor: UCMColorScheme.darkGray,
    );

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
      actions: curWwidth < 600
          ? null
          : [
              InkWell(
                hoverColor: const Color.fromARGB(255, 163, 5, 5),
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  print("aHHH");
                },
                child: TextButton.icon(
                  style: const ButtonStyle(
                    iconColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  label: const Text(
                    "Guest",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                  onPressed: null,
                  icon: const Icon(Icons.person),
                ),
              ),
              InkWell(
                hoverColor: const Color.fromARGB(255, 163, 5, 5),
                borderRadius: BorderRadius.circular(5),
                onTap: () {},
                child: TextButton.icon(
                  style: const ButtonStyle(
                    iconColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  label: const Text(
                    "Log In",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                  onPressed: null,
                  icon: const Icon(Icons.login_rounded),
                ),
              ),
              const SizedBox(width: 10),
            ],
      centerTitle: true,
      backgroundColor: UCMColorScheme.darkGray,
    );

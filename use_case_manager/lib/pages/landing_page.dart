import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:use_case_manager/components/color_scheme.dart';
import 'package:use_case_manager/components/ucm_appbar.dart';
import 'package:use_case_manager/components/ucm_drawer.dart';

class UseCaseManagerLandingPage extends StatefulWidget {
  const UseCaseManagerLandingPage({super.key});

  @override
  State<UseCaseManagerLandingPage> createState() =>
      _UseCaseManagerLandingPageState();
}

class _UseCaseManagerLandingPageState extends State<UseCaseManagerLandingPage> {
  bool signedIn = true;
  List<String> projNames = [
    "Project 1",
    "Project 2",
    "Project 3",
    "Project 4",
    "Project 5"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ucmAppBar(MediaQuery.of(context).size.width -
          MediaQuery.of(context).viewPadding.horizontal),
      body: SizedBox(
        width: MediaQuery.of(context).size.width -
            MediaQuery.of(context).viewPadding.horizontal,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).viewPadding.top,
        child: LayoutBuilder(
          builder: (c, constraints) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth / 15,
                  vertical: signedIn
                      ? constraints.maxHeight / 10
                      : constraints.maxHeight / 5),
              child: Container(
                decoration: const BoxDecoration(
                  color: UCMColorScheme.darkGray,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              color: UCMColorScheme.lightGray,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                "Welcome to Use Case Manager",
                                style: TextStyle(
                                    fontSize: 70,
                                    fontWeight: FontWeight.w600,
                                    color: UCMColorScheme.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Flexible(flex: 1, child: SizedBox()),
                      Flexible(
                        flex: 4,
                        child: signedIn
                            ? projectListDisplay()
                            : loginButtonDisplay(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      backgroundColor: UCMColorScheme.lightGray,
      drawer: UCMDrawer(navigateHome: () {}, navigateToProject: () {}),
    );
  }

  Widget loginButtonDisplay() {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        constraints: BoxConstraints(maxWidth: constraints.maxWidth / 1.5),
        decoration: BoxDecoration(
            color: UCMColorScheme.lightGray,
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 2,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                        backgroundColor: const MaterialStatePropertyAll(
                            UCMColorScheme.babyGray),
                      ),
                      onPressed: () {},
                      child: const FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          "Sign in with Google Account",
                          style: TextStyle(
                              fontSize: 20, color: UCMColorScheme.white),
                        ),
                      )),
                ),
              ),
              const Flexible(
                flex: 1,
                child: SizedBox(
                  height: 10,
                ),
              ),
              Flexible(
                flex: 2,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                      backgroundColor: const MaterialStatePropertyAll(
                          UCMColorScheme.roseRed),
                    ),
                    onPressed: () {},
                    child: const FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "Rose-Hulman Single Sign On",
                        style: TextStyle(
                            fontSize: 20, color: UCMColorScheme.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget projectListDisplay() {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        constraints: BoxConstraints(maxWidth: constraints.maxWidth / 1.5),
        decoration: BoxDecoration(
            color: UCMColorScheme.lightGray,
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 3,
                child: Material(
                  type: MaterialType.transparency,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: projNames.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemBuilder: (ct, n) {
                      return ListTile(
                        onTap: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        tileColor: UCMColorScheme.babyGray,
                        hoverColor: UCMColorScheme.darkGray,
                        title: Center(
                          child: Text(
                            projNames[n],
                            style: const TextStyle(color: UCMColorScheme.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        fixedSize:
                            const MaterialStatePropertyAll(Size.fromHeight(50)),
                        overlayColor: const MaterialStatePropertyAll(
                            UCMColorScheme.darkGray),
                        backgroundColor: const MaterialStatePropertyAll(
                            UCMColorScheme.roseRed),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)))),
                    onPressed: () {},
                    child: const Text(
                      "New Project",
                      style: TextStyle(color: UCMColorScheme.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

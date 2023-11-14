import 'package:flutter/material.dart';
import 'package:use_case_manager/components/color_scheme.dart';
import 'package:use_case_manager/model/login_argument.dart';

class LoginWindow extends StatelessWidget {
  const LoginWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: BoxDecoration(
            color: UCMColorScheme.lightGray,
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth / 20,
              vertical: constraints.maxHeight / 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                      backgroundColor: const MaterialStatePropertyAll(
                          UCMColorScheme.babyGray),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        "landing/email",
                        arguments: LoginArgument(signUp: false),
                      );
                    },
                    child: const Text(
                      "Sign in with Email",
                      style:
                          TextStyle(fontSize: 20, color: UCMColorScheme.white),
                    )),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(
                  height: 10,
                ),
              ),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                    backgroundColor:
                        const MaterialStatePropertyAll(UCMColorScheme.roseRed),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "landing/google");
                  },
                  child: const Text(
                    "SIgn in with Google",
                    style: TextStyle(fontSize: 20, color: UCMColorScheme.white),
                  ),
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(
                  height: 10,
                ),
              ),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                    backgroundColor:
                        const MaterialStatePropertyAll(UCMColorScheme.darkGray),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "landing/email",
                      arguments: LoginArgument(signUp: true),
                    );
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 20, color: UCMColorScheme.white),
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

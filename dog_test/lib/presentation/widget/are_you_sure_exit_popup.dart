import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AreYouSureExitPopup extends StatelessWidget {
  final Widget child;

  const AreYouSureExitPopup({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            barrierColor: Colors.black.withOpacity(.6),
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Column(
                  children: [
                    Text("data"),
                    SizedBox(
                      width: 100,
                      height: 100,
                      //child: Lottie.asset(Assets.animationAlert),
                    ),
                  ],
                ),
                content: Text("data"),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      "data",
                      style: const TextStyle(color: Colors.black),
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      "data",
                      style: const TextStyle(color: Colors.black),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ],
              );
            },
          ) ??
          false;
    }

    return WillPopScope(onWillPop: showExitPopup, child: child);
  }
}

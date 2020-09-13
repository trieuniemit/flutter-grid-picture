import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size =  MediaQuery.of(context).size.width / 2;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Center(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(
                  radius: 25,
                ),
                SizedBox(height: 15),
                Text(
                    'Saving...',
                    style: Theme.of(context).textTheme.headline6
                        .copyWith(fontWeight: FontWeight.normal)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
import 'package:flutter/material.dart';

class UserDrawerWidget extends StatelessWidget {
  const UserDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              color: Colors.grey,
              height: 49,
              width: 49,
            ),
          ),
          const SizedBox(width: 16,),
          const Flexible(
            child: Text("Victor"),
          )
        ],
      ),
    );
  }
}
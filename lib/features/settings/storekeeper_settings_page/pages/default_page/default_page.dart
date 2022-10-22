import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:flutter/material.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClAppBar(
        canPop: Navigator.of(context).canPop(),
        title: const Text("En construction"),
      ), 
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.engineering_outlined,
            size: 72,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 8,),

          const Flexible(
            child: Text(
              "Cette page est encore en cours de construction. Merci de revenir plus tard",
              textAlign: TextAlign.center,
            )
          ),
        ],
      ),
    );
  }
}
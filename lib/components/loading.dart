import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 255, 255, 0.4),
      child: Center(
        child: SpinKitChasingDots(
          color: Color.fromRGBO(0, 0, 0, 0.7),
          size: 50.0,
        ),
      ),
    );
  }
}

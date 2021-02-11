import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  @override
  LoadingButtonState createState() => LoadingButtonState();
}

class LoadingButtonState extends State<LoadingButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    controller.addListener(() {
      setState(() {});
    });
  }
    double bigContainerRadius = 80;
    double smallContainerRadius = 70;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onLongPress: () {
        controller.forward();
        setState(() {
          bigContainerRadius = bigContainerRadius == 80 ? 100 : 80;
          smallContainerRadius = smallContainerRadius == 70 ? 40 : 70;

        });
      },
      onVerticalDragStart: (DragStartDetails det) {
        controller.forward();
        setState(() {
          bigContainerRadius = bigContainerRadius == 80 ? 100 : 80;
          smallContainerRadius = smallContainerRadius == 70 ? 40 : 70;

        });
      },
      onLongPressEnd : (_) {
        if (controller.status == AnimationStatus.forward) {
          controller.reset();
            setState(() {
          bigContainerRadius = bigContainerRadius == 100 ? 80 : 100;
          smallContainerRadius = smallContainerRadius == 40 ? 70 : 40;
         print("up");
        });
        }},
      onTap : () {
        if (controller.status == AnimationStatus.forward) {
          controller.reset();
          setState(() {
            bigContainerRadius = bigContainerRadius == 100 ? 80 : 100;
            smallContainerRadius = smallContainerRadius == 40 ? 70 : 40;
            print("up");
          });
        }},
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
                    
          AnimatedContainer(
            duration: Duration(
              milliseconds: 400,
            ),
            height: bigContainerRadius,
            width: bigContainerRadius,
            decoration: BoxDecoration(
              color: Colors.grey[300].withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          ),
          AnimatedContainer(
            duration: Duration(
              milliseconds: 400,
            ),
            height: smallContainerRadius,
            width: smallContainerRadius,
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          ),
SizedBox(
            height: 100.0,
                width: 100.0,
            child: CircularProgressIndicator(
              value: controller.value,
              valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 90, 49, 244)),
            ),
          ),
          // SizedBox(
          //   height: 100.0,
          //       width: 100.0,
          // child: CircularProgressIndicator(
          //   value: 10.0,

          //   valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          // )),
          // SizedBox(
          //   height: 100.0,
          //       width: 100.0,
          //   child: CircularProgressIndicator(
          //     value: controller.value,
          //     valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          //   ),
          // ),
          // Container(
          //   height: 50,
          //   width: 50,

          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: Colors.orange
          //   ),
          // )
        ],
      ),
    );
  }
}

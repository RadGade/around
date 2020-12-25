import 'package:compound/ui/screensize_info.dart';
import 'package:flutter/material.dart';

import 'shared/ui_helpers.dart';

class BaseWidget extends StatelessWidget {
  final Widget Function(
      BuildContext context, SizingInformation sizingInformation) builder;
  const BaseWidget({Key key, this.builder}) : super(key: key);

  @override
Widget build(BuildContext context) {
  var mediaQuery = MediaQuery.of(context);

  return LayoutBuilder(builder: (context, boxSizing) {
    var sizingInformation = SizingInformation(
      orientation: mediaQuery.orientation,
      deviceType: getDeviceType(mediaQuery),
      screenSize: mediaQuery.size,
      localWidgetSize: Size(boxSizing.maxWidth, boxSizing.maxHeight),
    );

    return builder(context, sizingInformation);
  });
}
}
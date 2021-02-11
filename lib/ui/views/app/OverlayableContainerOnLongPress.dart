import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math';

/// -----------------------------------------------------------------
/// Widget that accepts an overlay to be displayed on top of itself
/// when a LongPress gesture is detected.
///
/// Required a specific Overlay higher in the hierarchy to be used
/// as a parent
/// -----------------------------------------------------------------
typedef OverlayableContainerOnLongPressBuilder(BuildContext context, VoidCallback hideOverlay);

class OverlayableContainerOnLongPress extends StatefulWidget {
  OverlayableContainerOnLongPress({
    Key key,
    @required this.child,
    @required this.overlayContentBuilder,
    this.onTap,
  }): super(key: key);

  final Widget child;
  final OverlayableContainerOnLongPressBuilder overlayContentBuilder;
  final VoidCallback onTap;

  @override
  _OverlayableContainerOnLongPressState createState() => _OverlayableContainerOnLongPressState();
}

class _OverlayableContainerOnLongPressState extends State<OverlayableContainerOnLongPress> {
  OverlayEntry _overlayEntry;

  @override
  void dispose() {
    _removeOverlayEntry();
    super.dispose();
  }

  void _removeOverlayEntry() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  ///
  /// Returns the position (as a Rect) of an item
  /// identified by its BuildContext
  ///
  Rect _getPosition(BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset topLeft = box.size.topLeft(box.localToGlobal(Offset.zero));
    final Offset bottomRight =
    box.size.bottomRight(box.localToGlobal(Offset.zero));
    return Rect.fromLTRB(
        topLeft.dx, topLeft.dy, bottomRight.dx, bottomRight.dy);
  }

  ///
  /// Displays an OverlayEntry on top of the selected item
  /// This overlay disappears if we click outside or, on demand
  ///
  void _showOverlayOnTopOfItem(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    final Rect overlayPosition = _getPosition(overlayState.context);

    // Get the coordinates of the item
    final Rect widgetPosition = _getPosition(context).translate(
      -overlayPosition.left,
      -overlayPosition.top,
    );

    // Generate the overlay entry
    _overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTap: () {
          ///
          /// Remove the overlay when we tap outside
          ///
          _removeOverlayEntry();
        },
        child: Material(
          color: Colors.black12,
          child: CustomSingleChildLayout(
            delegate: _OverlayableContainerLayout(widgetPosition),
            child: widget.overlayContentBuilder(context, _removeOverlayEntry),
          ),
        ),
      );
    });

    // Insert the overlayEntry on the screen
    overlayState.insert(
      _overlayEntry,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null){
          widget.onTap();
        }
      },
      onLongPress: () {
        _showOverlayOnTopOfItem(context);
      },
      child: widget.child,
    );
  }
}

class _OverlayableContainerLayout extends SingleChildLayoutDelegate {
  _OverlayableContainerLayout(this.position);

  final Rect position;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(Size(position.width, position.height));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(position.left, position.top);
  }

  @override
  bool shouldRelayout(_OverlayableContainerLayout oldDelegate) {
    return position != oldDelegate.position;
  }
}
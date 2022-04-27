import 'package:flutter/material.dart';

import 'package:flutter_portal/flutter_portal.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<MenuItem> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Card(
        elevation: 8,
        child: IntrinsicWidth(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({Key? key, required this.onComplete, required this.text})
      : super(key: key);

  final bool onComplete;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Row(
        children: [
          onComplete
              ? Icon(
                  Icons.check_rounded,
                  color: Colors.black,
                  size: 20,
                )
              : Icon(
                  Icons.close_rounded,
                  color: Colors.red,
                  size: 20,
                ),
          SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}

class OverlayTes extends StatefulWidget {
  const OverlayTes(
      {Key? key,
      required this.visible,
      required this.chil,
      required this.children})
      : super(key: key);

  final bool visible;
  final Widget chil;
  final List<MenuItem> children;

  @override
  _OverlayTesState createState() => _OverlayTesState();
}

class _OverlayTesState extends State<OverlayTes> {
  @override
  Widget build(BuildContext context) {
    return PortalEntry(
        visible: widget.visible,
        portal: Menu(children: widget.children),
        portalAnchor: Alignment.topLeft,
        childAnchor: Alignment.bottomLeft,
        child: widget.chil
        // IgnorePointer(
        //   ignoring: true,
        //   child: Text("data"),
        // ),
        );
  }
}

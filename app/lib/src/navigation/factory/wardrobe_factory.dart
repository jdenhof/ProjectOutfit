import 'dart:ui';

import 'package:flutter/material.dart';

class _WardrobeFactoryState extends State<WardrobeFactory>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation =
        CurveTween(curve: Curves.fastOutSlowIn).animate(animationController!);
  }

  void _showOverlay(BuildContext context, {required String text}) async {
    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return ClotheFactoryOverlay(
        animation: animation!,
        onBackPressed: () {
          animationController?.reverse();
          overlayEntry?.remove();
        },
      );
    });
    animationController!.addListener(() {
      overlayState!.setState(() {});
    });
    overlayState!.insert(overlayEntry!);
    animationController!.forward();
  }

  @override
  void dispose() {
    try {
      overlayEntry?.remove();
      overlayEntry?.dispose();
    } catch (e) {
      rethrow;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wardrobe Editor")),
      body: const Center(child: Text("Wardrobe Editor")),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showOverlay(context, text: ''),
        label: const Icon(Icons.add),
      ),
    );
  }
}

class _ClotheFactoryOverlayState extends State<ClotheFactoryOverlay> {
  String name = '';
  String category = '';
  String type = '';
  String brand = '';
  List<String> tags = [
    "test",
    "test",
    "test",
    "test",
    "test",
  ];

  List<Widget> _tagsToWidgets() {
    return tags.map((e) {
      return Container(
          color: Colors.purple, padding: EdgeInsets.all(10.0), child: Text(e));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.05,
      top: MediaQuery.of(context).size.height * .15,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          child: FadeTransition(
            opacity: widget.animation,
            child: Container(
              alignment: Alignment.center,
              color: Colors.grey.shade200,
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Container(
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.red,
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Icon(Icons.upload, size: 70),
                              ),
                            ),
                            Container(
                              padding: EdgeInsetsDirectional.only(
                                start: 10.0,
                              ),
                              color: Colors.yellow,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Name: $name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("Category: $category",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("Type: $type",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("Brand? $brand",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("Tags? ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  OverflowBar(
                                      overflowSpacing: 20.0,
                                      overflowAlignment:
                                          OverflowBarAlignment.start,
                                      overflowDirection: VerticalDirection.down,
                                      children: _tagsToWidgets()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Spacer(),
                          ElevatedButton(
                            child: Icon(Icons.arrow_back_ios),
                            onPressed: widget.onBackPressed,
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {},
                            child: Icon(Icons.delete),
                          ),
                          Spacer(),
                          ElevatedButton(
                            child: Icon(Icons.add),
                            onPressed: () {},
                          ),
                          const Spacer(),
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class ClotheFactoryOverlay extends StatefulWidget {
  const ClotheFactoryOverlay(
      {super.key, required this.animation, required this.onBackPressed});
  final Animation<double> animation;
  final VoidCallback onBackPressed;
  @override
  State<StatefulWidget> createState() => _ClotheFactoryOverlayState();
}

class WardrobeFactory extends StatefulWidget {
  const WardrobeFactory({super.key});

  static const routeName = "/wardrobeFactory";

  @override
  State<StatefulWidget> createState() => _WardrobeFactoryState();
}

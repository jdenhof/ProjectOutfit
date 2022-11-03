import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ootd/src/navigation/capture/camera_page.dart';

//Display of upload/clothing widget
class StaticDisplay extends StatefulWidget {
  const StaticDisplay({
    Key? key,
    required this.name,
    required this.category,
    required this.type,
    required this.brand,
    required this.tags,
  }) : super(key: key);

  final String name;
  final String category;
  final String type;
  final String brand;
  final String tags;

  @override
  State<StaticDisplay> createState() => _StaticDisplayState();
}

class _StaticDisplayState extends State<StaticDisplay> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        color: Colors.lightBlue[50],
        alignment: Alignment.center,
        child: Flex(
          direction: Axis.horizontal,
          children: [
            //Upload Photo Section
            const UploadPhoto(),
            //Clothing Item Data Section
            InfoDisplay(
              name: widget.name,
              category: widget.category,
              type: widget.type,
              brand: widget.brand,
              tags: widget.tags,
            ),
          ],
        ),
      ),
    );
  }
}

//Displays upload photo button then displays photo, tap to change
class UploadPhoto extends StatefulWidget {
  const UploadPhoto({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadPhoto> createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: image == null
              ? ElevatedButton(
                  onPressed: () => Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => const CameraScreen(
                        display: false,
                        reciever: '',
                      ),
                    ),
                  )
                      .then((value) {
                    setState(() {
                      image = value;
                    });
                  }),
                  child: const Icon(
                    Icons.upload_file,
                    size: 100,
                  ),
                )
              : Image.file(File(image!.path))),
    );
  }
}

//Updated display of currently selected clothing item info
class InfoDisplay extends StatelessWidget {
  const InfoDisplay({
    Key? key,
    required this.name,
    required this.category,
    required this.type,
    required this.brand,
    required this.tags,
  }) : super(key: key);

  final String name;
  final String category;
  final String type;
  final String brand;
  final String tags;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        padding: const EdgeInsets.only(top: 15.0, right: 10.0),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(category, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(brand, style: const TextStyle(fontWeight: FontWeight.bold)),
            TagsWidget(tags: tags),
          ],
        ),
      ),
    );
  }
}

//List of tags selected presented comma delemited
class TagsWidget extends StatelessWidget {
  const TagsWidget({
    Key? key,
    required this.tags,
  }) : super(key: key);

  final String tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tags: ", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          tags,
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }
}
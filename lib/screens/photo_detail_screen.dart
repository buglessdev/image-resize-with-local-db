import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/photos.dart';
import '../models/photo.dart';
import 'package:modern_form_esys_flutter_share/modern_form_esys_flutter_share.dart';
import 'dart:io';

class PhotoDetailScreen extends StatelessWidget {
  String id;
  PhotoDetailScreen(this.id);
  @override
  Widget build(BuildContext context) {
    List<Photo> photoList = Provider.of<Photos>(context).items
      ..retainWhere((item) => item.id == id);
    return Scaffold(
      appBar: AppBar(title: Text(photoList[0].name)),
      body: SizedBox(
        child: Card(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(photoList[0].image))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton.icon(
                    label: const Text('Share'),
                    icon: const Icon(Icons.share),
                    onPressed: () async {
                      var bytes = await photoList[0].image.readAsBytes();

                      Share.file('resized photo', 'photo.jpg',
                          bytes.buffer.asUint8List(), 'image/jpg');
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class PhotoInput extends StatefulWidget {
  Function onSelectPhoto;
  double _photoWidth;
  double _photoHeight;
  PhotoInput(this.onSelectPhoto, this._photoWidth, this._photoHeight);
  @override
  _PhotoInputState createState() => _PhotoInputState();
}

class _PhotoInputState extends State<PhotoInput> {
  File? _storedPhoto;

  final ImagePicker _picker = ImagePicker();

  Future<void> _takePhoto() async {
    final photoFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: widget._photoWidth,
        maxHeight: widget._photoHeight,
        imageQuality: 85);
    if (photoFile == null) {
      return;
    }
    setState(() {
      _storedPhoto = File(photoFile.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(photoFile.path);
    final savedPhoto =
        await File(photoFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectPhoto(savedPhoto);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 200,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedPhoto != null
              ? Image.file(
                  _storedPhoto!,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                )
              : Text(
                  'No Photo Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: TextButton.icon(
          icon: Icon(Icons.camera),
          onPressed: _takePhoto,
          label: Text(
            'Take Picture',
            textAlign: TextAlign.center,
          ),
        ))
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../providers/photos.dart';
import '../widgets/photo_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class AddPhotoScreen extends StatefulWidget {
  static const routeName = '/add-photo';
  @override
  _AddPhotoScreenState createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> {
  final _nameController = TextEditingController();

  double _photoWidth = 10.0;
  double _photoHeight = 10.0;

  File? _pickedPhoto;

  void _selectPhoto(File pickedPhoto) {
    _pickedPhoto = pickedPhoto;
  }

  void _savePhoto() {
    if (_nameController.text.isEmpty || _pickedPhoto == null) {
      return;
    }
    Provider.of<Photos>(context, listen: false)
        .addPhoto(_nameController.text, _pickedPhoto!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Photo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Name of photo'),
                    controller: _nameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: DropdownButton<String>(
                      items: <String>[
                        '150x200',
                        '120x320',
                        '240x320',
                        '400x600',
                        '800x900'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text('Please choose a size'),
                      onChanged: (newValue) {
                        setState(() {
                          _photoWidth = double.parse(newValue!.split('x')[0]);
                          _photoHeight = double.parse(newValue.split('x')[1]);
                        });
                      },
                    ),
                  ),
                  PhotoInput(_selectPhoto, _photoWidth, _photoHeight),
                  FlatButton(
                    onPressed: () {},
                    child: Text(''),
                  ),
                ],
              ),
            ),
          )),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Photo'),
            onPressed: _savePhoto,
            elevation: 0.0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}

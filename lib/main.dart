import 'package:flutter/material.dart';
import './providers/photos.dart';
import './widgets/button.dart';
import './widgets/image_buttons.dart';
import './screens/photo_list_screen.dart';
import 'package:provider/provider.dart';
import './screens/add_photo_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Photos(),
      child: MaterialApp(
        title: 'Photo Resize 2022',
        theme: ThemeData(primaryColor: Colors.red, accentColor: Colors.amber),
        home: PhotosList(),
        routes: {AddPhotoScreen.routeName: (context) => AddPhotoScreen()},
      ),
    );
  }
}

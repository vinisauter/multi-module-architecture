import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umbrella_module/routes.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const GalleryApp());
}

class GalleryApp extends StatelessWidget {
  const GalleryApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return const MaterialApp(
          restorationScopeId: 'rootGallery',
          title: 'Flutter Gallery',
          debugShowCheckedModeBanner: false,
          initialRoute: "/task",
          onGenerateRoute: RouteConfiguration.onGenerateRoute,
        );
      },
    );
  }
}

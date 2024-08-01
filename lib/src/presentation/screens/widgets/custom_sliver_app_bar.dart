import 'package:flutter/material.dart';

/// CustomSliverAppBar es un widget que muestra un SliverAppBar personalizado
/// con una imagen de fondo y un título centrado.
class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      centerTitle: true,
      pinned: true,
      backgroundColor: Colors.blueAccent,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text('Flutter Slow App', style: TextStyle(color: Colors.white)),
        background: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: <Color>[
                Colors.blueAccent,
                Colors.transparent,
              ],
            ),
          ),
          child: Image(
            fit: BoxFit.cover,
            image:
                AssetImage('assets/images/background.JPG'), // imagen de fondo
          ),
        ),
      ),
    );
  }
}

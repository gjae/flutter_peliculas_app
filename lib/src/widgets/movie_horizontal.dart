import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';


class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;

  final Function onFinishList;

  final double pixelBeforeListFinish;

  final _pageViewController = PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  MovieHorizontal({ 
    @required this.peliculas, 
    @required this.onFinishList, 
    this.pixelBeforeListFinish = 200 
  });

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    this._pageViewController.addListener(() {
      if (
          this._pageViewController.position.pixels >= 
          this._pageViewController.position.maxScrollExtent - this.pixelBeforeListFinish
      ) {
        this.onFinishList();
      }
    });

    return Container(

      width: double.infinity,
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageViewController,
        // children: _crearCards(context),
        itemBuilder: (context, i) {
          return _generateCard(peliculas[i], context);
        },
        itemCount: peliculas.length
      )
    );
  }

  List<Widget> _crearCards(BuildContext context) {
    return peliculas.map((p) =>_generateCard(p, context) ).toList();
  }
  

  Widget _generateCard(Pelicula p, BuildContext context) {
      final tarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(p.getPosterImg()),
                fit: BoxFit.cover,
                height: 160.0
              ),
            ),
            SizedBox(height: 5.0),
            Text(p.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption)
          ]
        ),
      );


      return GestureDetector(
        child: tarjeta,
        onTap: () {
          Navigator.pushNamed(context, 'detalle', arguments: p);
        },
      );
  }
}
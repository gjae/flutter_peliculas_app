import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {
  final peliculas = PeliculasProvider();
  
  @override
  Widget build(BuildContext context) {

    peliculas.getPopulares();
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: ()=> showSearch(context: context, delegate: DataSearchDelegate()),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _swipeTarjetas(context),
          _footer(context)
        ],
      )
    );
  }

  Widget _swipeTarjetas(BuildContext context) {
    return FutureBuilder(
      future: peliculas.getEnCines(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return CardSwiper(
          peliculas: snapshot.data,
          onCardTap: (pelicula) {
            Navigator.pushNamed(context, 'detalle', arguments: pelicula);
          },
        );
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(right: 15.0),
            child: Text('Peliculas populares', style: Theme.of(context).textTheme.subtitle2)
          ),
          SizedBox(height: 15.0),
          StreamBuilder(
            stream: peliculas.popularesStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  onFinishList: () => peliculas.getPopulares(),
                );
              }

              return CircularProgressIndicator();
            },
          )
        ]
      )
    );
  }
}
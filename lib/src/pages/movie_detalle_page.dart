import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_movie_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';


class MovieDetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar(pelicula, context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _posterTitulo(context, pelicula),
                 Divider(),
                _descripcion(context, pelicula),
              ]
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: _crearActoresPageview(context, pelicula),
      )
    );
  }


  Widget _crearAppBar(Pelicula pelicula, BuildContext context) {

    return SliverAppBar(
      elevation: 2.0,
      pinned: true,
      backgroundColor: Colors.indigoAccent,
      floating: false,
      expandedHeight: 220.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(pelicula.title),
        centerTitle: true,
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(pelicula.getBackgroundImage()),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }


  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(
              image: NetworkImage(pelicula.getPosterImg()),
              fit: BoxFit.cover,
              height: 150.0
            ),
          ),
          SizedBox(width: 7.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pelicula.title, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.clip),
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subtitle1),
                Text("Fecha de estreno: "+pelicula.releaseDate,  style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 5.0),
                Container(
                  width: 59,
                  padding: EdgeInsets.symmetric(horizontal: 4.5),
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star_outline, color: Colors.white, size: 19.0),
                      Text(pelicula.voteAverage.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                    ]
                  ),
                )
              ]
            )
          )
        ],
      ),
    );
  }

  Widget _descripcion(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13.0),
      child: Column(
        children: [
          Text(pelicula.overview, textAlign: TextAlign.justify),
        ],
      )
    );
  }

  
  Widget _crearActoresPageview(BuildContext context, Pelicula pelicula) {
    final provider = PeliculasProvider();


    return FutureBuilder(
      future: provider.getCast(pelicula.id.toString()),
      builder: (context, snapshot) {


        if( snapshot.hasData ) {
          return _actoresPageViewCards(snapshot.data);
        }

        return Center(
          child: CircularProgressIndicator()
        );
      }
    );
  }


  Widget _actoresPageViewCards(List data) {
    return Container(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        itemCount: data.length,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3
        ),
        itemBuilder: (context, index) => _actorCard(data[index]),
      )
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(actor.getFoto()),
              fadeInDuration: Duration(milliseconds: 150),
              fit: BoxFit.cover
            ),
          ),
          Text(actor.name, overflow: TextOverflow.ellipsis)
        ],
      )
    );
  }
}
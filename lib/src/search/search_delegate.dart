import 'package:flutter/material.dart';

class DataSearchDelegate extends SearchDelegate{

    List<String> peliculas = [
      'Spiderman',
      'Shazam!',
      'Batman',
      'Hombres de negro',
      'Capitana Marvel',
      'Bob esponja'
    ];  

    List<String> peliculasRecomendadas = [ 
      'Batman',
      'Hombres de negro'
    ];

    /// Acciones del AppBar
    @override
    List<Widget> buildActions(BuildContext context) {

      return <Widget>[
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            print("Click clear");
            query = '';
          }
        )
      ];
    }
  
    /// iCONOS AL INICIO (IZQUIERDA)
    @override
    Widget buildLeading(BuildContext context) {

      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          print("Close search clicked");
          close(context, null);
        },
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // TODO: implement buildResults
      return Container();
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      
      final listaPeliculas = (query.isEmpty) 
        ? peliculasRecomendadas
        : peliculas.where(
          (p) => p.toLowerCase().startsWith( query.toLowerCase() )
        ).toList();


        return ListView.builder(
          itemCount: listaPeliculas.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.movie),
              title: Text(listaPeliculas[index]),
            );
          },
        );
    }



}
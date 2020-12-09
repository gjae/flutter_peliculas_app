import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_movie_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = '9db0f5964aa5186ff985b144044ff143';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  bool _cargando = false;

  int _popularesPage = 0;
  List<Pelicula> _peliculas = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStream() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> getEnCines() async {
    final  url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': 1.toString()
    } );

    final resp = await this._procesarRespuesta(url);

    return resp;
  }

  Future<List<Pelicula>> getPopulares() async {

    if (_cargando) return [];

    _cargando = true;

    _popularesPage++;
    final  url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    } );

    final resp = await this._procesarRespuesta(url);

    this._peliculas.addAll(resp);
    popularesSink(this._peliculas);

    _cargando = false;
    return resp;
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{

    final resp = await http.get(url);

    final respBody = json.decode(resp.body);
    final items = Peliculas.fromJson(respBody['results']);

    return items.items;
  }


  Future<List<Actor>> getCast(String peliId) async {
    final uri = new Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key': _apiKey,
      'language': _language
    });

    final resp = await http.get(uri);

    final decodeData = json.decode(resp.body);

    Cast cast = new Cast.fromJson(decodeData['cast']);

    return cast.actores;
  }
}
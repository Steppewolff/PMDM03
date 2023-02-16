import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movies_app/models/credit_response.dart';

import '../models/models.dart';
import '../models/populars_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = 'df6d855374bc561065f6dd8cf0073e6d';
  String _language = 'es-ES';
  String _page = '1';

  List<Movie> onDisplayMovies = [];
  final int peliID = 0;

  MoviesProvider() {
    this.getOnDisplayMovies();
    this.getOnPopulars();
    this.getMovieCast(peliID);
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);
    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  List<Popular> onDisplayPopulars = [];

  getOnPopulars() async {
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final popularsResponse = PopularsResponse.fromJson(result.body);
    onDisplayPopulars = popularsResponse.results;

    notifyListeners();
  }

//Esto sirve para cargar la lista de objetos Cast, cada uno con un actor en el mapa casting, que tendrá pares de datos, int (id de la paelicula) y el listado de actores de la pelicula
  Map<int, List<Cast>> casting = {};
  List<Cast> movieCasting = [];

//Método asincrono para que se lea la lista de castings por pelicula y se pueda leer desde otras partes de la app
  Future<List<Cast>> getMovieCast(int peliID) async {
    print('Se descarga la informacion del casting del servidor OK');
    var url = Uri.https(_baseUrl, '3/movie/$peliID/credits',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final creditResponse = CreditResponse.fromJson(result.body);
    casting[peliID] = creditResponse.cast;
    var prueba = casting[peliID];
    if (prueba != null) {
      print(prueba[1].name);
    }
    notifyListeners(); //¿Es necesaria esta línea al declarar el tipo de variable que se retorna?¿Se puede borrar?
    return creditResponse.cast;
  }
}

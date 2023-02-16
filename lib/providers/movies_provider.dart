import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movies_app/models/credit_response.dart';
import 'package:movies_app/models/movieDetails_response.dart';

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
//Copiar estructura de getOnPopulars por ejemplo. La linea de notifyListeners es importante ara que se actualice el Mapa con la información
//la diferencia es que este método se llamará para una pelicula en concreto, para eso se le pasa un int con la ID de la pelicula
//Se declara el tipo de variable que devolverá el método, al ser de tipo asíncrono es importante
//En la linea de debajo va el nombre de la clase para obtener las listas en el lugar donde pone CreditResponse y el nombre del objeto creditResponse, cambiarlo en consecuencia
//En casting[peliID] se guarda la información de la clase Cast que se cree y se lea de CreditResponse
//Se devuelve la lista de objetos Cast, desde DetailsScreen ahora se debe recuperar esta lista de Future<List<Cast>>

//   getMovieCast(peliID) async {
//     print('Se descarga la informacion del casting del servidor OK');
//     var url = Uri.https(_baseUrl, '3/movie/$peliID/credits',
//         {'api_key': _apiKey, 'language': _language, 'page': _page});

//     // Await the http get response, then decode the json-formatted response.
//     final result = await http.get(url);
//     final creditResponse = CreditResponse.fromJson(result.body);
//     casting[peliID] = creditResponse.cast;
//     if (casting[peliID] != null) {
//       movieCasting = casting[peliID];
//     }
//     print('Casting actores');
//     print(peliID);
//     var prueba = casting[peliID];
//     if (prueba != null) {
//       print(prueba[1].name);
//     }
//     print('Post Casting actores');
// //   // notifyListeners(); //¿Es necesaria esta línea al declarar el tipo de variable que se retorna?¿Se puede borrar?
// //   // return casting[peliID];
// //   // return creditResponse.cast;
//     return movieCasting;
//   }

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
//    return casting[peliID];
    return creditResponse.cast;
  }

//   String movieTitle = "";
//   String originalTitle = "";
//   String posterPath = "";
//   double voteAverage = 0;

//   DetailsProvider(peliID) {
//     print('Movie Details Provider inicializado');
//     this.getOnDetailsMovie(peliID);
//   }
// //Ejemplo: https://api.themoviedb.org/3/movie/634649/credits?api_key=df6d855374bc561065f6dd8cf0073e6d&language=es-ES

//   getOnDetailsMovie(peliID) async {
//     var url = Uri.https(_baseUrl, '3/movie/$peliID/credits',
//         {'api_key': _apiKey, 'language': _language, 'page': _page});

//     // Await the http get response, then decode the json-formatted response.
//     final result = await http.get(url);
//     final movieDetailsResponse = MovieDetailsResponse.fromJson(result.body);
//     movieTitle = movieDetailsResponse.title;
//     originalTitle = movieDetailsResponse.originalTitle;
//     posterPath = movieDetailsResponse.posterPath;
//     voteAverage = movieDetailsResponse.voteAverage;

//     notifyListeners();
//   }
}

import 'package:flutter/material.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/movies_provider.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Canviar després per una instància de Peli
    final Movie peli = ModalRoute.of(context)?.settings.arguments as Movie;
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: peli),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitile(movie: peli),
                _Overview(movie: peli),
//Aquí se lee la info de las peliculas para empezar a mostrar
                CastingCards(peliID: peli.id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Exactament igual que la AppBaer però amb bon comportament davant scroll
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullPosterPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitile extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(movie.fullPosterPath),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            children: [
////////////////////////////////////////////////////////////////////////////////
//Aqui hay que hacer una nueva petición a la API con los datos de la pelicula, en el endpoint /movie/{movie_id}
//Ejemplo: https://api.themoviedb.org/3/movie/634649/credits?api_key=df6d855374bc561065f6dd8cf0073e6d&language=es-ES
//Se consigue la url de la peticion en https://developers.themoviedb.org/3/movies/get-movie-details, en el apartado de Try it out, en el de Defiition están las variables de cada endpoint
//La API key está en mi seccion de TMDB: https://www.themoviedb.org/settings/api
//Se puede ajustar lo que se deveuelve en el JSON de la TMDB en el SW Postman, marcando y desmarcando las opciones encima del JSON
//Se copia el JSON obtenido en Postman y se va a app.quicktype.io para que se cree la clase necesaria para obtener los datos del JSON
//Se pega el JSON de Postman en quicktype, se selecciona a la derecha el sw Dart y se selecciona debajo "Put encoder..." y "Use method names fromMap..."
//Se copia el código abajo izquierda y esa clase se pega en un nuevo archivo en models con el nombre de la nueva clase
//Se cambia el nombre de la clase por la que queramos ponerle en la app: hay que tener en cuenta que esto va a una clase que obtiene la respuesta del JSON (euqivalente a un DTO en JAVA), luego habrá que crear otra clase con el objetoque incorporaremos a la app, por ejemplo el objetot Cast con los actores
//Esta clase es la que utilizaremos para obtener los atributos que se mostrarán an la app
//Se hacen las modificaciones necesarias en el código (vídeo 5 aprox a partir del minuto 7:00), entre ellas los required para todos los parametros, los null safety (?) a la derecha de los atributos que pueden estar vacíos, borrar métodos que no se usan (cuidado con esto, esperar hasta el fina para estar seguro), atributos de tipo objeto que no hace falta, que pueden ser String
//Revisar los import dentro de cada clase y actualizar los export en el archivo models.dart
//Hay que darse cuenta que en el codigo obtenido Credits hay 2 Listas: cast y crew, es decir, se crean tantas listas como listados de elementos diferentes hay en el JSON, hay que tenerlo en cuenta
              Text(
                movie.title,
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                movie.originalTitle,
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Row(
                children: [
                  const Icon(Icons.star_outline, size: 15, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(movie.voteAverage.toString(), style: textTheme.caption),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}

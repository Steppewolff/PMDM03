// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:provider/provider.dart';
import '../providers/movies_provider.dart';

class CastingCards extends StatelessWidget {
//Aquí se muestran las casting cards, hay que traer la información de la clase
  final int peliID;

  const CastingCards({Key? key, required this.peliID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;

    print('prueba Casting_cards 1');
    print(peliID);

    FutureBuilder(
      future: moviesProvider.getMovieCast(peliID),

//La variable snapshot de la siguiente linea serán los datos que nos devuelva el movieCast, por lo que hay que indicar qé tipo de dato van a ser
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
// La variable casting es una lista de objetos Cast
        final casting = snapshot.data!;
        print('prueba Casting_cards 2');
        print(casting);
        print('prueba Casting_cards 3');
        print(snapshot);
        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) =>
                  _CastCard(cast: casting[index])),
        );
      },
    );

    return Container();
  }
}

class _CastCard extends StatelessWidget {
  final Cast cast;
  const _CastCard({Key? key, required this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
//Aqui se carga el atributo de cast, foto del actor
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(cast.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
//Aqui se carga el atributo de cast, nombre del actor
          Text(
            cast.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

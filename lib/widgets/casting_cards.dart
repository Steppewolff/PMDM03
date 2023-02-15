import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:provider/provider.dart';
import '../providers/movies_provider.dart';

class CastingCards extends StatelessWidget {
//Aquí se muestran las casting cards, hay que traer la información de la clase
  final int peliID;

  const CastingCards(this.peliID);

  @override
  Widget build(BuildContext context) {
    try {
      final moviesProvider =
          Provider.of<MoviesProvider>(context, listen: false);

      FutureBuilder(
        future: moviesProvider.getMovieCast(peliID),
//La variable snapshot de la siguiente linea serán los datos que nos devuelva el movieCast, por lo que hay que indicar qé tipo de dato van a ser
//Cast da error porque todavía no he creado la clase, tampoco he creado returnCastings o como se haya llamado
//De este snapshot ya se podrá extraer toda la informacón que necesitamos
        builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
//La variable casting es una lista de objtos Cast
          final casting = snapshot.data!;

          return Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            // color: Colors.red,
            child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
//Aqui se carga el dato de
                itemBuilder: (BuildContext context, int index) =>
                    _CastCard(cast: casting[index])),
          );
        },
      );
    } catch (e) {
      print(e);
      rethrow;
    }
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
      // color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////
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
